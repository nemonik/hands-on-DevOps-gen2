#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a

skip_encrypted_variables=true

. ../.env

gitlab_protocol="${gitlab_protocol,,}"
if [ "${gitlab_protocol}" == "https" ]; then
    gitlab_entrypoint="websecure"
    gitlab_tls="true"
    gitlab_https="true"
else
    gitlab_entrypoint="web"
    gitlab_tls="false"
    gitlab_https="false"
fi

db_key_base=`pwgen -Bsv1 64`
secret_key_base=`pwgen -Bsv1 64`
otp_key_base=`pwgen -Bsv1 64`

images_into_registry gitlab_images

template_file ./templates/gitlab-chart-values.yaml.tpl gitlab-chart-values.yaml

template_file ./templates/gitlab-IngressTcpRoute.yaml.tpl gitlab-IngressTcpRoute.yaml

notify "Spinning up GitLab..."

helm repo add nemonik https://nemonik.github.io/helm-charts/

helm repo update

helm install gitlab nemonik/gitlab --namespace ${gitlab_namespace} --create-namespace -f gitlab-chart-values.yaml

kubectl apply -f gitlab-IngressTcpRoute.yaml

gitlab_pod_name=`kubectl get pod -n ${gitlab_namespace} -l "app.kubernetes.io/component=gitlab" -o json | jq -r '.items | .[] | .metadata.name'`

notify "Waiting for pod/${gitlab_pod_name} -n ${gitlab_namespace} to become ready..."

kubectl wait --for=condition=Ready pod/${gitlab_pod_name} -n ${gitlab_namespace} --timeout 360s

notify "Waiting til GitLab is responding to https requests..."

token=`pwgen -Bsv1 20`

loop=0
while : ; do

  if [ $loop -eq 4 ]; then
    error "Failed post step."
    break
  fi

  if curl --silent ${gitlab_protocol}://${gitlab_fdqn} | grep -q "sign_in"; then
    notify "Performing post ready configuration setup..."
    kubectl exec -it pod/${gitlab_pod_name} -n ${gitlab_namespace} -- /bin/bash -c "bundle exec rails runner -e production \"user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: [:api], name: 'Automation_token'); token.set_token('$token'); token.save\""   
    curl --request PUT --header "PRIVATE-TOKEN: $token" "${gitlab_protocol}://${gitlab_fdqn}/api/v4/application/settings?signup_enabled=false&allow_local_requests_from_hooks_and_services=true&auto_devops_enabled=false&send_user_confirmation_email=false&allow_local_requests_from_hooks_and_services=true" | jq '.'
    kubectl exec -it pod/${gitlab_pod_name} -n ${gitlab_namespace} -- /bin/bash -c "bundle exec rails runner -e production \"PersonalAccessToken.find_by_token('$token').revoke!\""
    notify "Completed post step."
    break
  fi

  notify "Still waiting for GitLab to respond to ${gitlab_protocol} requests..."
  sleep 15
done

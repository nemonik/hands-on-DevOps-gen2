#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -e
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

is_current_context_correct

is_cluster_running

images_into_registry gitlab_images

template_file ./templates/gitlab-chart-values.yaml.tpl gitlab-chart-values.yaml

template_file ./templates/gitlab-IngressTcpRoute.yaml.tpl gitlab-IngressTcpRoute.yaml

notify "Spinning up GitLab..."

helm repo add nemonik https://nemonik.github.io/helm-charts/

helm repo update

create_namespace ${gitlab_namespace}

helm install gitlab nemonik/gitlab --namespace ${gitlab_namespace} -f gitlab-chart-values.yaml

kubectl apply -f gitlab-IngressTcpRoute.yaml

gitlab_pod_name=`kubectl get pod -n ${gitlab_namespace} -l "app.kubernetes.io/component=gitlab" -o json | jq -r '.items | .[] | .metadata.name'`

notify "Waiting for pod/${gitlab_pod_name} -n ${gitlab_namespace} to become ready..."

kubectl wait --for=condition=Ready pod/${gitlab_pod_name} -n ${gitlab_namespace} --timeout 600s

notify "Waiting til GitLab is responding to https requests..."

loop=0
while : ; do

  if [ $loop -eq 15 ]; then
    warn
    warn "GitLab appears to have failed to come up in the expected amount on time. Abnormal, but this doesn't mean it will never come up. The automation will keep trying til either GitLab comes up or you interrupt the automation."
    warn
  fi

  if curl --silent ${gitlab_protocol}://${gitlab_fdqn} | grep -q "sign_in"; then
    notify "Performing post ready configuration setup..."

    notify "Creating GitLab automation token..."

    read gitlab_pod_name gitlab_token < <(create_automation_token)

    notify "Configuring GitLab via REST api..."

    rest_api_loop=0
    for (( ; ; )); do

      if [ $rest_api_loop -eq 15 ]; then
        warn
        warn "GitLab REST API is refusing to let us to connect.  The autonation will keep trying til either this works or you interrupt the automation."
        warn
      fi

      output=`curl --silent --request PUT --header "PRIVATE-TOKEN: $gitlab_token" "${gitlab_protocol}://${gitlab_fdqn}/api/v4/application/settings?${gitlab_settings}" | jq '.' 2>&1`
      if [[ "${output}" == *"401 Unauthorized"* ]] || [[ "${output}" == *"Invalid numeric literal"* ]]; then
        echo $output | jq -r "."
      else
        echo $output | jq -r "."
        break
      fi

      sleep 5

      notify "   Attempting again..."
      ((rest_api_loop++))
    done

    revoke_automation_token $gitlab_pod_name $gitlab_token

    notify "Completed post step."
    break
  fi

  notify "  Still waiting for GitLab to respond to ${gitlab_protocol} requests..."
  ((loop++))
  sleep 60
done

notify "Done."

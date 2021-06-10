#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. ../.env

drone_protocol="${drone_protocol,,}"
if [ "${drone_protocol}" == "https" ]; then
    drone_entrypoint="websecure"
    drone_tls="true"
else
    drone_entrypoint="web"
    drone_tls="false"
fi

drone_database_secret=`openssl rand -hex 16`
drone_rpc_secret=`openssl rand -hex 16`
drone_secret_plugin_token=`openssl rand -hex 16`

images_into_registry drone_images

notify "Creating a GitLab token to integrate Drone with GitLab through the following automation..."

token=`tr -dc A-Za-z0-9 </dev/urandom | head -c 20`

gitlab_pod_name=`kubectl get pod -n ${gitlab_namespace} -l "app.kubernetes.io/component=gitlab" -o json | jq -r '.items | .[] | .metadata.name'`

kubectl exec -it pod/${gitlab_pod_name} -n ${gitlab_namespace} -- /bin/bash -c "bundle exec rails runner -e production \"user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: [:api], name: 'Automation_token'); token.set_token('${token}'); token.save\""

notify "Delete the prior Drone CI application integration from GitLab, if it exists..."

application_id=`curl --silent --request GET --header "PRIVATE-TOKEN: $token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications" | jq '. [] | select(.application_name=="Drone") | .id'`

if [ -n "$application_id" ]; then
  ## Delete prior Drone CI application
  curl --silent --request DELETE --header "PRIVATE-TOKEN: $token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications/${application_id}"
fi

notify "Adding the Drone CI application integration to GitLab..."
application_values=`curl --silent --request POST --header "PRIVATE-TOKEN: ${token}" --data "name=Drone&redirect_uri=${drone_protocol}://${drone_fdqn}:${drone_port}/login&scopes=api+read_user" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications"`

drone_gitlab_client_id=`notify "${application_values}" | jq '.application_id'`
drone_gitlab_client_secret=`notify "${application_values}" | jq ".secret"`

notify "Revoking the token used to perform the prior automation..."

kubectl exec -it pod/${gitlab_pod_name} -n ${gitlab_namespace} -- /bin/bash -c "bundle exec rails runner -e production \"PersonalAccessToken.find_by_token('$token').revoke!\""

template_file ./templates/drone-chart-values.yaml.tpl drone-chart-values.yaml

template_file ./templates/drone-kubernetes-secrets-chart-values.yaml.tpl drone-kubernetes-secrets-chart-values.yaml

template_file ./templates/drone-runner-kube-chart-values.yaml.tpl drone-runner-kube-chart-values.yaml

template_file ./templates/drone-ingress.yaml.tpl drone-ingress.yaml

notify "Spinning up Drone CI..."

helm repo add drone https://charts.drone.io

helm repo update

helm install drone -f drone-chart-values.yaml --namespace ${drone_namespace} --create-namespace drone/drone

kubectl apply -f drone-ingress.yaml

helm install drone-kubernetes-secrets -f drone-kubernetes-secrets-chart-values.yaml --namespace ${drone_namespace} --create-namespace drone/drone-kubernetes-secrets

helm install drone-runner-kube -f drone-runner-kube-chart-values.yaml --namespace ${drone_namespace} --create-namespace drone/drone-runner-kube

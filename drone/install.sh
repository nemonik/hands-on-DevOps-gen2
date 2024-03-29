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

is_current_context_correct

is_cluster_running

images_into_registry drone_images

notify "Creating a GitLab token to integrate Drone with GitLab through the following automation..."

read gitlab_pod_name gitlab_token < <(create_automation_token)

notify "Delete the prior Drone CI application integration from GitLab, if it exists..."

application_id=`curl --silent --request GET --header "PRIVATE-TOKEN: $gitlab_token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications" | jq '. [] | select(.application_name=="Drone") | .id'`

if [ -n "$application_id" ]; then
  ## Delete prior Drone CI application
  curl --silent --request DELETE --header "PRIVATE-TOKEN: $gitlab_token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications/${application_id}"
fi

notify "Adding the Drone CI application integration to GitLab..."
application_values=`curl --silent --request POST --header "PRIVATE-TOKEN: ${gitlab_token}" --data "name=Drone&redirect_uri=${drone_protocol}://${drone_fdqn}:${drone_port}/login&scopes=api+read_user" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications"`

drone_gitlab_client_id=`echo "${application_values}" | jq '.application_id'`
drone_gitlab_client_secret=`echo "${application_values}" | jq ".secret"`

revoke_automation_token $gitlab_pod_name $gitlab_token

template_file ./templates/drone-chart-values.yaml.tpl drone-chart-values.yaml

template_file ./templates/drone-kubernetes-secrets-chart-values.yaml.tpl drone-kubernetes-secrets-chart-values.yaml

template_file ./templates/drone-runner-kube-chart-values.yaml.tpl drone-runner-kube-chart-values.yaml

template_file ./templates/drone-ingress.yaml.tpl drone-ingress.yaml

notify "Spinning up Drone CI..."

helm repo add drone https://charts.drone.io

helm repo update

create_namespace $drone_namespace

helm install drone -f drone-chart-values.yaml --namespace ${drone_namespace} drone/drone

kubectl apply -f drone-ingress.yaml

helm install drone-kubernetes-secrets -f drone-kubernetes-secrets-chart-values.yaml --namespace ${drone_namespace} drone/drone-kubernetes-secrets

helm install drone-runner-kube -f drone-runner-kube-chart-values.yaml --namespace ${drone_namespace} drone/drone-runner-kube

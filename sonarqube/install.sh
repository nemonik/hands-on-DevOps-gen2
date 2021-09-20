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

sonarqube_protocol="${sonarqube_protocol,,}"
if [ "${sonarqube_protocol}" == "https" ]; then
    sonarqube_entrypoint="websecure"
    sonarqube_tls="true"
else
    sonarqube_entrypoint="web"
    sonarqube_tls="false"
fi

images_into_registry sonarqube_images

notify "Integrate SonarQube into GitLab..."

notify "Creating a GitLab token for the following automation..."

read gitlab_pod_name gitlab_token < <(create_automation_token)

notify "Delete the prior SonarQube application integration from GitLab, if it exists..."

application_id=`curl --silent --request GET --header "PRIVATE-TOKEN: $gitlab_token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications" | jq '. [] | select(.application_name=="SonarQube") | .id'`

if [ -n "$application_id" ]; then
  # Delete prior SonarQube application.
  curl --silent --request DELETE --header "PRIVATE-TOKEN: $gitlab_token" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications/${application_id}"
fi

notify "Adding the SonarQube application integration to GitLab..."
application_values=`curl --silent --request POST --header "PRIVATE-TOKEN: ${gitlab_token}" --data "name=SonarQube&redirect_uri=${sonarqube_protocol}://${sonarqube_fdqn}:${sonarqube_port}/oauth2/callback/gitlab&scopes=api+read_user" "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}/api/v4/applications"`

sonar_auth_gitlab_applicationid=`echo "${application_values}" | jq '.application_id'`
sonar_auth_gitlab_secret=`echo "${application_values}" | jq ".secret"`

revoke_automation_token $gitlab_pod_name $gitlab_token

template_file ./templates/sonarqube-chart-values.yaml.tpl sonarqube-chart-values.yaml
template_file ./templates/sonarqube-ingress.yaml.tpl sonarqube-ingress.yaml

notify "Integrated SonarQube with GitLab."

notify "Spinning up Sonarqube..."
helm repo add oteemocharts https://oteemo.github.io/charts

helm repo update

kubectl create namespace ${sonarqube_namespace}

helm install sonarqube oteemocharts/sonarqube --namespace ${sonarqube_namespace} --create-namespace -f sonarqube-chart-values.yaml

kubectl apply -f sonarqube-ingress.yaml

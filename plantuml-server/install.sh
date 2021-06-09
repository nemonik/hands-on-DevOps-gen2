#!/bin/bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. ../.env

plantuml_server_protocol="${plantuml_server_protocol,,}"
if [ "${plantuml_server_protocol}" == "https" ]; then
    plantuml_server_entrypoint="websecure"
    plantuml_server_tls="true"
else
    plantuml_server_entrypoint="web"
    plantuml_server_tls="false"
fi

images_into_registry plantuml_server_images

template_file ./templates/plantuml-server-chart-values.yaml.tpl plantuml-server-chart-values.yaml

notify "Spinning up PlantUML-Server..."

helm repo add nemonik https://nemonik.github.io/helm-charts/

helm repo update

helm install plantuml-server nemonik/plantuml-server --namespace ${plantuml_server_namespace} --create-namespace -f plantuml-server-chart-values.yaml


#!/bin/bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. ../.env

heimdall_protocol="${heimdall_protocol,,}"
if [ "${heimdall_protocol}" == "https" ]; then
    heimdall_entrypoint="websecure"
    heimdall_tls="true"
else
    heimdall_entrypoint="web"
    heimdall_tls="false"
fi

images_into_registry heimdall_images

template_file ./templates/heimdall-chart-values.yaml.tpl heimdall-chart-values.yaml

notify "Spinning up Heimdall2..."

helm repo add nemonik https://nemonik.github.io/helm-charts/

helm repo update

helm install heimdall2 nemonik/heimdall --namespace ${heimdall_namespace} --create-namespace -f heimdall-chart-values.yaml


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

taiga_protocol="${taiga_protocol,,}"
if [ "${taiga_protocol}" == "https" ]; then
    taiga_websocket_protocol="wss"
    taiga_entrypoint="websecure"
    taiga_tls="true"
else
    taiga_websocket_protocol="ws"
    taiga_entrypoint="web"
    taiga_tls="false"
fi

taiga_secret_key=`pwgen -Bsv1 64`

images_into_registry taiga_images

template_file ./templates/taiga-chart-values.yaml.tpl taiga-chart-values.yaml

template_file ./templates/createsuperuser.sh.tpl createsuperuser.sh

notify "Spinning up Taiga..."

helm repo add nemonik https://nemonik.github.io/helm-charts/

helm repo update

helm install taiga nemonik/taiga --namespace ${taiga_namespace} --create-namespace -f taiga-chart-values.yaml

taiga_gateway_pod_name=`kubectl get pods -n taiga -l app.kubernetes.io/component=taiga-gateway -o json | jq -r '.items | .[] | .metadata.name'`

notify "Waiting for pod/${taiga_gateway_pod_name} -n ${taiga_namespace} to become ready..."

kubectl wait --for=condition=Ready pod/${taiga_gateway_pod_name} -n ${taiga_namespace} --timeout 360s

loop=0
while : ; do

  if [ $loop -eq 4 ]; then
    error "Failed post step."
    break
  fi

  notify "Attempting to pull ${taiga_protocol}://${taiga_fdqn}..."

  if curl -sD - -o /dev/null "${taiga_protocol}://${taiga_fdqn}"; then

    kubectl run create-super-user --image=${taiga_back_image_name}:${taiga_back_image_tag} -n ${taiga_namespace} --env "RABBITMQ_USER=taiga" --env "RABBITMQ_PASS=taiga" \
      --env "CELERY_ENABLED=false" --env "TAIGA_SECRET_KEY=${taiga_secret_key}" --env "POSTGRES_DB=taiga" --env "POSTGRES_USER=taiga" \
      --env "POSTGRES_PASSWORD=taiga" --env "POSTGRES_HOST=taiga-db" --env "TAIGA_SITES_DOMAIN=${taiga_fdqn}" --env "TAIGA_SITES_SCHEME=${taiga_protocol}" \
      --restart=Never --command -- /bin/bash -c "while true; do sleep 30; done"

    kubectl wait --for=condition=Ready pod/create-super-user -n ${taiga_namespace} --timeout 360s

    kubectl cp createsuperuser.sh ${taiga_namespace}/create-super-user:/taiga-back/.

    notify "Waiting for taiga-db to be listening and the Django migrations of occured..."

    kubectl exec -it create-super-user -n ${taiga_namespace} -n ${taiga_namespace} -- /bin/bash -c ' \
       apt update && \
       apt install netcat expect -y && \
       while ! nc -zv taiga-db 5432; do sleep 15; done && \
       chmod +x ./createsuperuser.sh && \
       echo -n "Attempting to create root user..." &&  \
       until ./createsuperuser.sh &>/dev/null; do sleep 15; echo -n "."; done && \
       echo "" && \
       echo "Done."'
    kubectl delete pod -n ${taiga_namespace} create-super-user --wait=false

    notify "Complete post step"
    break
  else
    notify "Taiga not yet reponding to ${taiga_protocol}..."
    sleep 30
  fi
done

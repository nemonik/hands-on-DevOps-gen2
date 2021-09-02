#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a

. ../.env

images_into_registry traefik_images

template_file ./templates/traefik-chart-values.yaml.tpl traefik-chart-values.yaml

template_file ./templates/traefik-cert-secrets.yaml.tpl traefik-cert-secrets.yaml

template_file ./templates/traefik-tlsstore.yaml.tpl traefik-tlsstore.yaml

notify "Spinning up Traefik..."

helm repo add traefik https://helm.traefik.io/traefik

helm repo update

create_namespace $traefik_namespace

helm install traefik traefik/traefik --namespace ${traefik_namespace} --values traefik-chart-values.yaml

kubectl apply -f traefik-cert-secrets.yaml

kubectl apply -f traefik-tlsstore.yaml

#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

source -e
. .env

echo Uninstalling Drone CI... 

helm uninstall drone --namespace ${namespace}

helm uninstall drone-kubernetes-secrets --namespace ${namespace}

helm uninstall drone-runner-kube --namespace ${namespace}

kubectl delete -f drone-ingress.yaml

kubectl delete namespace ${namespace}

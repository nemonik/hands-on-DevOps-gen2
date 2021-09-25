#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a

. ../.env

is_current_context_correct

is_cluster_running

echo Uninstalling Drone CI...

helm uninstall drone --namespace ${drone_namespace}

helm uninstall drone-kubernetes-secrets --namespace ${drone_namespace}

helm uninstall drone-runner-kube --namespace ${drone_namespace}

kubectl delete -f drone-ingress.yaml

kubectl delete namespace ${drone_namespace}

#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. .env

if curl --silent -k "http://${registry_name}:${registry_port}/v2/_catalog" > /dev/null; then

  notify "Using existing container registry: http://${registry_name}:${registry_port}"

else

  notify "Creating container registry http://${registry_name}:${registry_port}"

  IFS='-' read -ra parts <<< "${registry_name}"

  k3d registry create ${parts[1]} -p ${registry_port}

fi

cluster_json="$(k3d cluster list -o json)"

if [ "$(echo $clusters_json | jq -r --arg k3d_cluster_name ${k3d_cluster_name} '. [] | select(.name==$k3d_cluster_name) | .name')" != "${k3d_cluster_name}" ]; then

  notify "Cluster doesn't exist, so created it..."

  k3d cluster create ${k3d_cluster_name} \
    --api-port host.k3d.internal:6443 -p 80:80@loadbalancer -p 443:443@loadbalancer \
    -p 9000:9000@loadbalancer -p 2022:2022@loadbalancer --k3s-server-arg "--no-deploy=traefik" \
    --registry-use ${registry_name}:${registry_port} \
    --servers ${k3d_server_count} --agents ${k3d_agent_count}

else

  notify "Cluster exists, so starting it instead..."

  k3d cluster start ${k3d_cluster_name}

fi

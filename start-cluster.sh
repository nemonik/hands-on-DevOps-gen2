#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>
 
set -a

skip_encrypted_variables=true

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

  images_into_registry k3d_images

  cmd="k3d cluster create ${k3d_cluster_name} \
    --api-port 6443 -p 80:80@loadbalancer -p 443:443@loadbalancer \
    -p 9000:9000@loadbalancer -p 2022:2022@loadbalancer --k3s-arg \"--disable=traefik@server:*\" \
    --registry-use ${registry_name}:${registry_port} \
    --image ${registry_name}:${registry_port}/${k3s_image_name}:${k3s_image_tag} \
    --servers ${k3d_server_count} --agents ${k3d_agent_count}"
# https://github.com/rancher/k3d/issues/133 for Pods evicted due to NodeHasDiskPressure
#    --k3s-server-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%' \
#    --k3s-server-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%'"

  if [ $( docker ps -a | grep ${pullthrough_registry_name} | wc -l ) -gt 0 ]; then

    notify "Pullthrough registry is running.  Configuring cluster to use."

    cmd="${cmd} --registry-config ./pullthrough-registry/registries.yaml"

  else

    notify "**No** pull through registry detected,so nt configuring to use."
  fi

  echo $cmd

  eval "${cmd} || true"
 
else

  notify "Cluster exists, so starting it instead..."

  k3d cluster start ${k3d_cluster_name}

fi

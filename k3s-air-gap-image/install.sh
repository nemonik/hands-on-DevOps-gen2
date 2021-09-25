#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -e
set -a

skip_encrypted_variables=true

. ../.env

image_name=$(get_image_name ${k3s_canonical_image})
image_tag=$(get_image_tag ${k3s_canonical_image})

eval "k3s_image_name=\"${image_name}\""

eval "k3s_image_tag=\"${image_tag}\""

k3s_airgap_image_filename=$(basename $k3s_airgap_images_url)

template_file templates/Dockerfile.tpl Dockerfile

if [[ -f "./${k3s_airgap_image_filename}" ]]; then
  notify "Using existing k3s air gap file found at $(pwd)/$k3s_airgap_image_filename"
else 
  curl -s ${k3s_airgap_images_url} -o $k3s_airgap_image_filename
fi

docker build -t nemonik/k3s:${k3s_image_tag} .
docker tag nemonik/k3s:${k3s_image_tag} ${registry_name}:${registry_port}/nemonik/k3s:${k3s_image_tag}
docker push ${registry_name}:${registry_port}/nemonik/k3s:${k3s_image_tag}

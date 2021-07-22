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

if [ "${pullthrough_registry_enabled}" = "true" ]; then 

  if [ $( docker ps -a | grep ${pullthrough_registry_name} | wc -l ) -gt 0 ]; then

    notify "pullthrough registry already exists."

    docker start ${pullthrough_registry_container_name} >/dev/null 2>&1

  else

    notify "Creating pullthrough registry at localhost:${pullthrough_registry_port}"

    template_file ./templates/registries.yaml.tpl registries.yaml

    cmd="docker run --detach --volume $(pwd)/config.yml:/etc/docker/registry/config.yml --name ${pullthrough_registry_name} --publish ${pullthrough_registry_port}:5000/tcp registry:2 > /dev/null"

    echo $cmd
    eval "${cmd}"
  fi

  notify "Now running..."
  echo
  notify "Ensure your docker daemon configure file contains:"
  echo
  notify "  \"registry-mirrors\": [\"http://host.k3d.internal:${pullthrough_registry_port}\"],"
  echo
  notify "to use use your pullthrough registry."
else
  
  notify "Pullthrough registry not enabled."

fi

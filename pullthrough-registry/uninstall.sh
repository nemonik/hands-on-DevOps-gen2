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

if [ $( docker ps -a | grep ${pullthrough_registry_name} | wc -l ) -gt 0 ]; then

  notify "Uninstalling pullthrough registry..."

  docker stop ${pullthrough_registry_name} > /dev/null 2>&1
  docker rm ${pullthrough_registry_name} > /dev/null
else

  notify "pullthrough registry doesn't exist."

fi

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

notify "Creating registry ${registry_name}:${registry_port}"

k3d registry create ${registry_name/k3d-/} -p ${registry_port}

if [ "${?}" = "1" ]; then
  notify "Ignore the Fail notice. This is okay."
fi

notify "Waiting til ${registry_name}:${registry_port} is running..."

until [ "`docker inspect -f {{.State.Running}} ${registry_name}`"=="true" ]; do
    sleep 5;
done;

notify "Now running."

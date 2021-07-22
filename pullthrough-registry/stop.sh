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

notify "Stopping pullthrough registry at localhost:${pullthrough_registry_port}"

docker stop ${pullthrough_registry_name} > /dev/null

notify "Now stopped"

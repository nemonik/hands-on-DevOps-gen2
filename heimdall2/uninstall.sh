#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

# Uninstall PlantUML-Server

set -a

skip_encrypted_variables=true

. ../.env

is_current_context_correct

is_cluster_running

helm uninstall heimdall2 --namespace ${heimdall_namespace}

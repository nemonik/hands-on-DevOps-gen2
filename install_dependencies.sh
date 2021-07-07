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

cd ansible

warn "Ansible will not validate the password you enter, so be careful to enter your password correctly."

ansible-playbook -vvv -i hosts main.yaml --ask-become-pass

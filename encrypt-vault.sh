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

if file vault | grep -q "openssl"; then
  echo "Vault is already encrypted."
  exit 1
fi
if [[ ! -v VAULT_PASSWORD ]]; then
  echo "Enter vault password to encrypt:"
  read VAULT_PASSWORD
else
  echo "Using VAULT_PASSWORD env variable to encrypt..."
fi

openssl enc -base64 -e -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -pass pass:${VAULT_PASSWORD} -in ./vault -out ./vault_new

mv ./vault_new ./vault

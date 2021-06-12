# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

SHELL := /bin/bash
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: all install start-registry delete-registry start-cluster delete-cluster patch-coredns install-traefik uninstall-traefik install-gitlab uninstall-gitlab install-drone uninstall-drone install-taiga uninstall-taiga install-sonarqube uninstall-sonarqube decrypt-vault encrypt-vault

all: start install
start: start-registry start-cluster patch-coredns
install: install-traefik install-gitlab install-drone install-taiga install-sonarqube 
start-registry:
	./start_registry.sh
delete-registry:
	./delete_registry.sh
start-cluster:
	./start_cluster.sh
delete-cluster:
	./delete_cluster.sh
patch-coredns:
	cd coredns && ./patch.sh
install-traefik:
	cd traefik && ./install.sh
uninstall-traefik:
	cd traefik && ./uninstall.sh
install-gitlab:
	cd gitlab && ./install.sh
uninstall-gitlab:
	cd gitlab && ./uninstall.sh
install-drone:
	cd drone && ./install.sh
uninstall-drone:
	cd drone && ./uninstall.sh
install-taiga:
	cd taiga && ./install.sh
uninstall-taiga:
	cd taiga && ./uninstall.sh
install-sonarqube:
	cd sonarqube && ./install.sh
uninstall-sonarqube:
	cd sonarqube && ./uninstall.sh
decrypt-vault:
	@if ! file vault | grep -q "openssl"; then \
	  echo "Vault is not encrypted."; \
	  exit 1; \
	fi  
	@if [[ ! -v VAULT_PASSWORD ]]; then \
	  echo "Enter vault password to decrypt:"; \
	  read VAULT_PASSWORD; \
	else \
	  echo "Using VAULT_PASSWORD env variable to decrypt..."; \
	fi
	@openssl enc -base64 -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -pass pass:${VAULT_PASSWORD} -in ./vault -out ./vault_new
	@mv ./vault_new ./vault
encrypt-vault:
	@file_type=$(/bin/file ./vault)
	@if file vault | grep -q "openssl"; then \
	  echo "Vault is already encrypted."; \
	  exit 1; \
	fi
	@if [[ ! -v VAULT_PASSWORD ]]; then \
	  echo "Enter vault password to encrypt:"; \
	  read VAULT_PASSWORD; \
	else \
	  echo "Using VAULT_PASSWORD env variable to encrypt..."; \
	fi
	@openssl enc -base64 -e -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -pass pass:${VAULT_PASSWORD} -in ./vault -out ./vault_new
	@mv ./vault_new ./vault

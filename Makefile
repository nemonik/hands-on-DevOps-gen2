# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

SHELL := /bin/bash
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: all depends? install install-dependencies start-registry delete-registry start-cluster delete-cluster patch-coredns install-traefik uninstall-traefik install-gitlab uninstall-gitlab install-drone uninstall-drone install-taiga uninstall-taiga install-sonarqube uninstall-sonarqube install-heimdall uninstall-heimdall decrypt-vault encrypt-vault

all: depends? start install
start: start-registry start-cluster patch-coredns
install: install-traefik install-gitlab install-drone install-taiga install-sonarqube install-heimdall
uninstall: delete-cluster
install-dependencies:
	./install_dependencies.sh
depends?:
	./has_depends.sh
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
install-heimdall:
	cd heimdall2 && ./install.sh
uninstall-heimdall:
	cd heimdall2 && ./uninstall.sh
decrypt-vault:
	./decrypt-vault.sh
encrypt-vault:
	./encrypt-vault.sh

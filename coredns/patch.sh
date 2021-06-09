#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. ../.env

notify "Patching DNS in the cluster to resolve application FDQNs..."

node_hosts=$(kubectl get cm coredns -n kube-system --template='{{.data.NodeHosts}}')

IFS='
'

new_node_hosts=""

for node_host in $node_hosts
do
  match=false
  for entry in "${coredns_entries[@]}"
  do
    if [[ "${node_host}" == *"${entry}"* ]]; then
      match=true
    fi
  done

  if [ "$match" = false ]; then
      if [[ !  -z  $new_node_hosts ]]; then
        new_node_hosts="${new_node_hosts}\n${node_host}"
      else
        new_node_hosts="${node_host}"
      fi
  fi
done

for entry in "${coredns_entries[@]}"
do
  new_node_hosts="$new_node_hosts\n${host_ip} ${entry}"
done

patch=`echo $new_node_hosts | xargs -0 printf '{"data": {"NodeHosts":"%s"}}'`

patch_command="kubectl patch cm coredns -n kube-system -p='${patch}'"

echo $patch_command

eval $patch_command

notify "Forcing retart of coredns so that the tests can run immediately..."

kubectl rollout restart deployment coredns -n kube-system

kubectl rollout status deployment coredns -n kube-system 

kube_dns_pod_name=`kubectl get pod -n kube-system -l "k8s-app=kube-dns" -o json | jq -r '.items | .[] | .metadata.name'`

kubectl wait --for=condition=Ready pod/${kube_dns_pod_name} -n kube-system --timeout 360s

cd tests

eval ./test_patch.sh

cd ..

notify "Remember to add any new entries to /etc/hosts!"

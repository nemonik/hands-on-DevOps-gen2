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

images_into_registry traefik_images

notify "Get host ip..."

kubectl run get-host-ip --image=${registry_name}:${registry_port}/${traefik_image_name}:${traefik_image_tag} --restart=Never --command -- sh -c "while true; do sleep 15; done"

kubectl wait --for=condition=Ready pod/get-host-ip --timeout 360s

notify "Block waiting for CoreDNS to start responding... "

kubectl exec pod/get-host-ip -- sh -c "loop=true && while \$loop; do if ping -c 1 host.k3d.internal; then loop=false; echo \"found\"; else sleep 5; fi; done"

output=`kubectl exec pod/get-host-ip -- sh -c "nslookup host.k3d.internal"`

read -ra parts <<< "${output##*$'\n'}"

host_ip="${parts[1]}"

kubectl delete pod/get-host-ip --wait=false

notify "Patching DNS in the cluster to resolve application FDQNs using ${host_ip} ip..."

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

current_kube_dns_pod_name=`kubectl get pod -n kube-system -l "k8s-app=kube-dns" -o json | jq -r '.items | .[] | .metadata.name'`

kubectl rollout restart deployment coredns -n kube-system

kubectl rollout status deployment coredns -n kube-system

while : ; do

  kube_dns_pod_name=`kubectl get pod -n kube-system -l "k8s-app=kube-dns" -o json | jq -r '.items | .[] | .metadata.name'`

  if [[ "${kube_dns_pod_name}" == *"${current_kube_dns_pod_name}"* ]]; then
    sleep 0.5
  else
   break
  fi

done

kubectl wait --for=condition=Ready pod ${kube_dns_pod_name} -n kube-system --timeout 360s

## The test has a built in ping loop needed to block until coredns is responding.
##

cd tests

eval ./test_patch.sh

cd ..

echo
warn "======================================================="
warn "Your host IP is ${host_ip}"
warn "Writing ${host_ip} into /tmp/host_ip"
warn "======================================================="

echo "${host_ip}" > /tmp/host_ip

echo
warn "======================================================="
warn "Ensure the following lines are in your /etc/hosts file:"
warn "======================================================="
echo

echo "127.0.0.1 host.k3d.internal"

for entry in "${coredns_entries[@]}"
do
  echo "127.0.0.1 $entry"
done

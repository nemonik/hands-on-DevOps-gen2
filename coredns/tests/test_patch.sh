#!/usr/bin/env bash

# Copyright (C) 2021 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

set -a
. ../../.env

notify "Using ${registry_name}:${registry_port}/${traefik_image_name}:${traefik_image_tag} container to query coreDNS for entries..."

images_into_registry traefik_images

kubectl run test-coredns --image=${registry_name}:${registry_port}/${traefik_image_name}:${traefik_image_tag} --restart=Never --command -- sh -c "while true; do sleep 15; done"

kubectl wait --for=condition=Ready pod/test-coredns --timeout 360s

notify "Block waiting for CoreDNS to start responding... "
warn "This may go forever."

kubectl exec pod/test-coredns -- sh -c "loop=true && while \$loop; do if ping -c 1 host.k3d.internal; then loop=false; echo \"found\"; else sleep 5; fi; done"

notify "Query the DNS server for the FDQNs added..."

for entry in "${coredns_entries[@]}"; do
  kubectl exec pod/test-coredns -- nslookup $entry
done

kubectl delete pod/test-coredns --wait=false


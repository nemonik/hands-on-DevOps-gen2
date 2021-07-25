FROM ${k3s_image_name}:${k3s_image_tag}

LABEL maintainer "Michael Joseph Walsh <github.com@nemonik.com>"

RUN mkdir -p /var/lib/rancher/k3s/agent/images/

COPY ./${k3s_airgap_image_filename} /var/lib/rancher/k3s/agent/images/${k3s_airgap_image_filename}

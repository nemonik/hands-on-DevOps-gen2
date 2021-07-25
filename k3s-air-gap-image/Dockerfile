FROM rancher/k3s:v1.21.2-k3s1

LABEL maintainer "Michael Joseph Walsh <github.com@nemonik.com>"

RUN mkdir -p /var/lib/rancher/k3s/agent/images/

COPY ./k3s-airgap-images-amd64.tar.gz /var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64.tar.gz

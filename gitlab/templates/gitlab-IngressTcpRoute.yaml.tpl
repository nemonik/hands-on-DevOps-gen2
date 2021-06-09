apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteTCP
metadata:
  name: gitlab-ingressroutetcp
  namespace: ${gitlab_namespace}

spec:
  entryPoints:
    - gitssh
  routes:
  - match: HostSNI(`*`) 
    services:
    - name: gitlab-gitlab
      port: 2022

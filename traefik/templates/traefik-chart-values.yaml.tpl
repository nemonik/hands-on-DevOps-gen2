image:
  name: ${registry_name}:${registry_port}/${traefik_image_name}
  tag: "${traefik_image_tag}"

deployment:
  replicas: 1

ports:
  web:
    redirectTo: websecure
  websecure:
    tls:
      enabled: true

  gitssh:
    port: 2022
    expose: true
    exposedPort: 2022
    protocol: TCP

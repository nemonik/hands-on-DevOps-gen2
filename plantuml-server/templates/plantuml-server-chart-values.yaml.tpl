image:
  repository: ${registry_name}:${registry_port}/${plantuml_server_image_name}
  tag: "${plantuml_server_image_tag}"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: ${plantuml_server_entrypoint}
    traefik.ingress.kubernetes.io/router.tls: "${plantuml_server_tls}"
  hosts:
    - host: ${plantuml_server_fdqn}
      paths:
        -  "/"
  tls: []


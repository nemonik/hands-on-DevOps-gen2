
databasePassword: ${heimdall_database_password}
jwtSecret: ${heimdall_jwt_secret}

postgresql:
  enable: true

  image:
    repository: ${registry_name}:${registry_port}/${postgres_image_name}
    pullPolicy: IfNotPresent
    tag: "${postgres_image_tag}"

  persistence:
    enabled: true
    size: '100Mi'
    storageClassName: local-path
    accessMode: "ReadWriteOnce"


heimdall:
  image:
    repository: ${registry_name}:${registry_port}/${heimdall_image_name}
    pullPolicy: IfNotPresent
    tag: "${heimdall_image_tag}"

  ingress:
    enabled: true
    annotations:
      traefik.ingress.kubernetes.io/router.entrypoints: ${heimdall_entrypoint}
      traefik.ingress.kubernetes.io/router.tls: "${heimdall_tls}"
    hosts:
      - host: ${heimdall_fdqn}
        paths:
          -  "/"


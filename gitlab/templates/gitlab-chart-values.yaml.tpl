redis:
  image:
    repository:  ${registry_name}:${registry_port}/${redis_image_name}
    tag: "${redis_image_tag}"
    pullPolicy: "IfNotPresent"

  persistence:
    storageClassName: local-path
    enabled: true

postgresql:
  image:
    repository: ${registry_name}:${registry_port}/${postgresql_image_name}
    tag: "${postgresql_image_tag}"
    pullPolicy: "IfNotPresent"

  persistence:
    storageClassName: local-path
    enabled: true

gitlab:
  image:
    repository: ${registry_name}:${registry_port}/${gitlab_image_name}
    tag: "${gitlab_image_tag}"
    pullPolicy: "IfNotPresent"

  service:
    type: ClusterIP
    http:
      port: 80
    ssh: 
      port: 2022

  ingress:
    enabled: true
    annotations:
      traefik.ingress.kubernetes.io/router.entrypoints: "${gitlab_entrypoint}"
      traefik.ingress.kubernetes.io/router.tls: "${gitlab_tls}"
    hosts:
      - host: "${gitlab_fdqn}"
        paths:
          -  "/"
    tls: []

  persistence:
    data:
      storageClassName: local-path
      enabled: true

  env:
    host: ${gitlab_fdqn}

    signupEnabled: "false"
    
    secrets:
       dbKeyBase: "${db_key_base}"
       secretKeyBase: "${secret_key_base}"
       otpKeyBase: "${otp_key_base}"

    ssh:
      listenPort: "22"
      port: "2022"

    https: "${gitlab_https}"

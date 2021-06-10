image:
  repository: ${registry_name}:${registry_port}/${drone_image_name}
  tag: "${drone_image_tag}"
  pullPolicy: IfNotPresent

persistentVolume:
  enabled: true
  accessModes:
    - ReadWriteOnce
  annotations: {}
  existingClaim: ""
  mountPath: /data
  size: 8Gi
  storageClass: local-path
  volumeMode: ""
  subPath: ""

resources: {}

nodeSelector: {}

tolerations: []

affinity: {}

env:
  DRONE_SERVER_HOST: ${drone_fdqn}
  DRONE_SERVER_PROTO: ${drone_protocol}
  DRONE_RPC_SECRET: ${drone_rpc_secret}
  # DRONE_DATABASE_DRIVER:
  # DRONE_DATABASE_DATASOURCE:
  DRONE_DATABASE_SECRET: ${drone_database_secret}
  DRONE_GIT_ALWAYS_AUTH: true
  DRONE_GITLAB_CLIENT_ID: ${drone_gitlab_client_id}
  DRONE_GITLAB_CLIENT_SECRET: ${drone_gitlab_client_secret}
  DRONE_GITLAB_SERVER: ${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}
  DRONE_GITLAB_SKIP_VERIFY: true
  #DRONE_LOGS_DEBUG: true
  #DRONE_LOGS_TRACE: true

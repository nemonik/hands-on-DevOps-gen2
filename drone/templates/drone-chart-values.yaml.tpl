image:
  repository: ${registry_name}:${registry_port}/${drone_image_name}
  tag: "${drone_image_tag}"
  pullPolicy: IfNotPresent

resources: {}

nodeSelector: {}

tolerations: []

affinity: {}

env:

  ## REQUIRED: Set the user-visible Drone hostname, sans protocol.
  ## Ref: https://docs.drone.io/installation/reference/drone-server-host/
  ##
  DRONE_SERVER_HOST: ${drone_fdqn}

  ## The protocol to pair with the value in DRONE_SERVER_HOST (http or https).
  ## Ref: https://docs.drone.io/installation/reference/drone-server-proto/
  ##
  DRONE_SERVER_PROTO: ${drone_protocol}

  ## REQUIRED: Set the secret secret token that the Drone server and its Runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  DRONE_RPC_SECRET: ${drone_rpc_secret}

  ## If you'd like to use a DB other than SQLite (the default), set a driver + DSN here.
  ## Ref: https://docs.drone.io/installation/storage/database/
  ##
  # DRONE_DATABASE_DRIVER:
  # DRONE_DATABASE_DATASOURCE:

  ## If you are going to store build secrets in the Drone database, it is suggested that
  ## you set a database encryption secret. This must be set before any secrets are stored
  ## in the database.
  ## Ref: https://docs.drone.io/installation/storage/encryption/
  ##
  DRONE_DATABASE_SECRET: ${drone_database_secret}

  ## If you are using self-hosted GitHub or GitLab, you'll need to set this to true.
  ## Ref: https://docs.drone.io/installation/reference/drone-git-always-auth/
  ##
  DRONE_GIT_ALWAYS_AUTH: true

  ## GitLab-specific variables. See the provider docs here:
  ## Ref: https://docs.drone.io/installation/providers/gitlab/
  ##
  DRONE_GITLAB_CLIENT_ID: ${drone_gitlab_client_id}
  DRONE_GITLAB_CLIENT_SECRET: ${drone_gitlab_client_secret}
  DRONE_GITLAB_SERVER: ${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}

  ## Boolean value disables TLS verification when establishing a connection to the remote GitLab 
  ## server. The default value is false.  Since self hosted GitLab uses a self-signe cert, 
  ## drone will complain `x509: certificate signed by unknown authority` and the login will fail
  ## unles set to `true`. 
  DRONE_GITLAB_SKIP_VERIFY: true

  ## Debug
  ##
  #DRONE_LOGS_DEBUG: true
  #DRONE_LOGS_TRACE: true

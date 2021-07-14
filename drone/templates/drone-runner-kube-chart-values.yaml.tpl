image:
  repository:  ${registry_name}:${registry_port}/${drone_runner_kube_image_name}
  tag: "${drone_runner_kube_image_tag}"
  pullPolicy: IfNotPresent

replicaCount: ${drone_runner_replica_count}

rbac:
  buildNamespaces:
    - ${drone_namespace}

resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

env:
  ## REQUIRED: Set the secret secret token that the Kubernetes runner and its runners will use
  ## to authenticate. This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-rpc-secret/
  ##
  DRONE_RPC_SECRET: ${drone_rpc_secret}

  ## Determines the default Kubernetes namespace for Drone builds to run in.
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-namespace-default/
  ##
  DRONE_NAMESPACE_DEFAULT: ${drone_namespace}

  ## Disable SSL verification when making http requests to the Drone server. 
  DRONE_RPC_SKIP_VERIFY: true

  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-endpoint/
  #
  DRONE_SECRET_PLUGIN_ENDPOINT: http://drone-kubernetes-secrets:3000

  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-token/
  #
  DRONE_SECRET_PLUGIN_TOKEN: ${drone_secret_plugin_token}

  ## Debugging
  ##
  #DRONE_DEBUG: true
  #DRONE_TRACE: true
  #
  #DRONE_RPC_DUMP_HTTP: true
  #DRONE_RPC_DUMP_HTTP_BODY: true

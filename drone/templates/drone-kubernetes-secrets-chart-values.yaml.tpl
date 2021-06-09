image:
  repository:  ${registry_name}:${registry_port}/${kubernetes_secrets_image_name}
  tag: "${kubernetes_secrets_image_tag}"
  pullPolicy: IfNotPresent

replicaCount: 1

env:
  ## The Kubernetes namespace to retrieve secrets from.
  ##
  KUBERNETES_NAMESPACE: "default"


  ## REQUIRED: Shared secret value for comms between the Kubernetes runner and this secrets plugin.
  ## Must match the value set in the runner's env.DRONE_SECRET_PLUGIN_TOKEN.
  ## Ref: https://kube-runner.docs.drone.io/installation/reference/drone-secret-plugin-token/
  ## This is commented out in order to leave you the ability to set the
  ## key via a separately provisioned secret (see existingSecretName above).
  ##
  SECRET_KEY: "${drone_secret_plugin_token}"

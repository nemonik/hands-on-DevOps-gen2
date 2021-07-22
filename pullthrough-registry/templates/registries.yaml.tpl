mirrors:
  k3d-registry.nemonik.com:5000:
    endpoint:
    - http://k3d-registry.nemonik.com:5000

  docker.io:
    endpoint:
    - http://host.k3d.internal:${pullthrough_registry_port}

iconfigs: {}
auths: {}

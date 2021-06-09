persistence:
  media:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce
  static:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce

env: 
  taigaURL: "${taiga_protocol}://${taiga_fdqn}:${taiga_port}"
  taigaWebsocketsURL: "${taiga_websocket_protocol}://${taiga_fdqn}:${taiga_port}"

  taigaSitesDomain: "${taiga_fdqn}"
  taigaSitesScheme: "${taiga_protocol}"

  ## See: https://github.com/kaleidos-ventures/taiga-docker/issues/15
  # enableGitlabAuth: "true"
  # gitlabClientID: "081b14908c5016983bd9343f31bbd887b391f57062e20a7c4c5d2063c69aabb2"
  # gitlabApiClientSecret: "bfa4e43f6aed5b6780c19491b9678b53b1178df8b601c2df325095d97976ca1a"
  # gitlabURL: "https://gitlab.nemonik.com"

  
taigaAsyncRabbitmq:

  image:
    repository: ${registry_name}:${registry_port}/${rabbitmq_image_name}
    pullPolicy: IfNotPresent
    tag: "${rabbitmq_image_tag}"

  persistence:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce

  service:
    type: ClusterIP
    port: 5672

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaAsync:

  image:
    repository: ${registry_name}:${registry_port}/${taiga_back_image_name}      
    pullPolicy: IfNotPresent
    tag: "${taiga_back_image_tag}"

  service:
    type: ClusterIP
    port: 8000

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}

  
taigaBack:

  image:
    repository: ${registry_name}:${registry_port}/${taiga_back_image_name}
    pullPolicy: IfNotPresent
    tag: "${taiga_back_image_tag}"

  service:
    type: ClusterIP
    port: 8000

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaDB:

  image:
    repository: ${registry_name}:${registry_port}/${postgres_image_name}
    pullPolicy: IfNotPresent
    tag: "${postgres_image_tag}"

  persistence:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce

  service:
    type: ClusterIP
    port: 5432

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaEventsRabbitmq:

  image:
    repository: ${registry_name}:${registry_port}/${rabbitmq_image_name}
    pullPolicy: IfNotPresent
    tag: "${rabbitmq_image_tag}"

  persistence:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce

  service:
    type: ClusterIP
    port: 5672

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaEvents:

  image:
    repository: ${registry_name}:${registry_port}/${taiga_events_image_name}     
    pullPolicy: IfNotPresent
    tag: "${taiga_events_image_tag}"

  service:
    type: ClusterIP
    port: 8888

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaFront:

  image:
    repository: ${registry_name}:${registry_port}/${taiga_front_image_name}  
    pullPolicy: IfNotPresent
    tag: "${taiga_front_image_tag}"

  service:
    type: ClusterIP
    port: 80

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaGateway:

  image:
    repository: ${registry_name}:${registry_port}/${nginx_image_name}    
    pullPolicy: IfNotPresent
    tag: "${nginx_image_tag}"

  persistence:
    enabled: true
    size: 100Mi
    storageClassName: local-path
    accessMode: ReadWriteOnce

  ingress:
    enabled: true
    annotations:
      traefik.ingress.kubernetes.io/router.entrypoints: ${taiga_entrypoint}
      traefik.ingress.kubernetes.io/router.tls: "${taiga_tls}"
    hosts:
      - host: ${taiga_fdqn}
        paths:
          -  "/"
    tls: []

  service:
    type: ClusterIP
    port: 80

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}


taigaProtected:

  image:
    repository: ${registry_name}:${registry_port}/${taiga_protected_image_name}     
    pullPolicy: IfNotPresent
    tag: "${taiga_protected_image_tag}"

  service:
    type: ClusterIP
    port: 8003

  podAnnotations: {}

  podSecurityContext: {}

  securityContext: {}

  resources: {}

  nodeSelector: {}

  tolerations: []

  affinity: {}

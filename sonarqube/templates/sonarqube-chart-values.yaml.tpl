image:
  repository: ${registry_name}:${registry_port}/${sonarqube_image_name}
  tag: "${sonarqube_image_tag}"
  pullPolicy: IfNotPresent

ingress:
  enabled: true
  hosts:
    - name: ${sonarqube_fdqn}
      path: /
  annotations: 
    traefik.ingress.kubernetes.io/router.entrypoints: ${sonarqube_entrypoint}
    traefik.ingress.kubernetes.io/router.tls: "${sonarqube_tls}"

persistence:
  enabled: true
  storageClass: local-path
  accessMode: ReadWriteOnce
  size: 10Mi

initContainers:
  image: ${registry_name}:${registry_port}/${busybox_image_name}:${busybox_image_tag}
  
initSysctl:
  image: ${registry_name}:${registry_port}/${busybox_image_name}:${busybox_image_tag}

env:
 - name: SONAR_CORE_SERVERBASEURL
   value: "${sonarqube_protocol}://${sonarqube_fdqn}:${sonarqube_port}"
 - name: SONAR_AUTH_GITLAB_ENABLED
   value: "true"
 - name: SONAR_AUTH_GITLAB_URL
   value: "${gitlab_protocol}://${gitlab_fdqn}:${gitlab_port}"
 - name: SONAR_AUTH_GITLAB_APPLICATIONID
   value: ${sonar_auth_gitlab_applicationid}
 - name: SONAR_AUTH_GITLAB_SECRET
   value: ${sonar_auth_gitlab_secret}
 - name: SONAR_AUTH_GITLAB_GROUPSSYNC
   value: "true"

postgresql:
  enabled: true
  postgresqlUsername: "sonarUser"
  postgresqlPassword: "sonarPass"
  postgresqlDatabase: "sonarDB"

  image:
    registry: ${registry_name}:${registry_port}
    repository: ${postgresql_image_name}
    tag: "${postgresql_image_tag}"

  service:
    port: 5432

#  resources:
#    limits:
#      cpu: 2
#      memory: 2Gi
#    requests:
#      cpu: 100m
#      memory: 200Mi

  persistence:
    enabled: true
    accessMode: ReadWriteOnce
    size: 10Mi
    storageClass: local-path

  securityContext:
    enabled: true
    fsGroup: 1001
    runAsUser: 1001
  volumePermissions:
    enabled: false
    securityContext:
      runAsUser: 0
  shmVolume:
    chmod:
      enabled: false
  serviceAccount:
    enabled: false

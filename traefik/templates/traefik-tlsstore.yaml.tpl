---
apiVersion: traefik.containo.us/v1alpha1
kind: TLSStore
metadata:
  name: default
  namespace: ${traefik_namespace}
spec:
  defaultCertificate:
    secretName: traefik-cert

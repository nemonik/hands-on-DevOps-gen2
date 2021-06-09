---
apiVersion: v1
kind: Secret
metadata:
  name: traefik-cert
  namespace: ${traefik_namespace}
data:
  tls.crt: |
   ${traefik_tls_crt}
  tls.key: |
   ${traefik_tls_key}

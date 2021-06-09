kind: Ingress
apiVersion: networking.k8s.io/v1
metadata:
  name: drone-ingress
  namespace: ${drone_namespace}
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: ${drone_entrypoint}
    traefik.ingress.kubernetes.io/router.tls: "${drone_tls}"
spec:
  rules:
  - host: ${drone_fdqn}
    http:
      paths:
      -  path: /
         pathType: Prefix
         backend:
           service:
             name: drone
             port: 
               name: http

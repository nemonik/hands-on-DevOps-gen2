apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sonarqube
  namespace: ${sonarqube_namespace}
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: ${sonarqube_entrypoint}
    traefik.ingress.kubernetes.io/router.tls: "${sonarqube_tls}"
  labels:
    app.kubernetes.io/app: sonarqube
    app.kubernetes.io/instance: sonarqube
spec:
  rules:
  - host: ${sonarqube_fdqn}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sonarqube-sonarqube
            port:
              name: http

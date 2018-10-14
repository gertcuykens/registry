#!/bin/bash
openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout registry.key \
  -x509 -days 365 -out config/registry.crt

docker run --entrypoint htpasswd registry:latest -Bbn admin admin > config/htpasswd

kubectl delete secret registry
kubectl create secret generic registry \
  --from-literal=http-secret=admin \
  --from-file=config/registry.crt \
  --from-file=config/registry.key \
  --from-file=config/htpasswd

kubectl create configmap registry --from-file=config/registry.yml

# mkdir -p ~/.docker/certs.d/localhost:5000
# cp tls/registry.crt ~/.docker/certs.d/localhost:5000/client.cert
# cp tls/registry.key ~/.docker/certs.d/localhost:5000/client.key
# cat domain.crt intermediate-certificates.pem > certs/domain.crt

# kubectl create secret docker-registry index.docker.io \
#   --docker-server=https://index.docker.io/v1/ \
#   --docker-username=... \
#   --docker-password=... \
#   --docker-email=...

# echo -n admin | base64
# echo -n YWRtaW4= | base64 -D

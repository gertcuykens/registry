#!/bin/bash
kubectl create secret generic registry \
  --from-literal=http-secret=seed \
  --from-file=../config/registry.crt \
  --from-file=../config/registry.key \
  --from-file=../config/htpasswd

kubectl create configmap registry --from-file=../config/registry.yml

# kubectl create secret docker-registry index.docker.io \
#   --docker-server=https://index.docker.io/v2/ \
#   --docker-username=... \
#   --docker-password=... \
#   --docker-email=...

# echo -n admin | base64
# echo -n YWRtaW4= | base64 -D

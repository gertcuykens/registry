#!/bin/bash

# openssl req \
#   -newkey rsa:4096 -nodes -sha256 -keyout config/registry.key \
#   -x509 -days 365 -out config/registry.crt

# docker run --entrypoint htpasswd registry:latest -Bbn admin admin > config/htpasswd

# docker run -d --restart=always \
docker run -it --rm \
  --name registry \
  -v `pwd`/config:/config \
  -v /tmp:/var/lib/registry \
  -e REGISTRY_HTTP_ADDR=:5000 \
  -e REGISTRY_HTTP_SECRET=seed \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/config/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=/config/registry.key \
  -e REGISTRY_STORAGE_DELETE_ENABLED=true \
  -e REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/var/lib/registry \
  -p 5000:5000 \
  registry:latest

# -e REGISTRY_AUTH=htpasswd \
# -e REGISTRY_AUTH_HTPASSWD_REALM=Registry \
# -e REGISTRY_AUTH_HTPASSWD_PATH=/config/htpasswd \

# docker run -it --rm \
#   --name registry \
#   -v `pwd`/config:/config \
#   -v /tmp:/var/lib/registry \
#   registry:latest garbage-collect /config/registry.yml

# /etc/hosts
# 127.0.0.1 localhost nats registry
# ::1       localhost nats registry

# https://docs.docker.com/registry/configuration/
# https://docs.docker.com/engine/swarm/stack-deploy/

# mkdir -p ~/.docker/certs.d/localhost:5000
# cp tls/registry.crt ~/.docker/certs.d/localhost:5000/client.cert
# cp tls/registry.key ~/.docker/certs.d/localhost:5000/client.key
# cat domain.crt intermediate-certificates.pem > certs/domain.crt

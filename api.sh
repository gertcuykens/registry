#!/bin/bash
# https://github.com/docker/distribution/blob/master/docs/spec/api.md

if [ "$1" == "catalog" ]
then
  curl -ksS "https://registry:5000/v2/_catalog?n=10" \
  -H "Accept: application/vnd.docker.distribution.manifest.v2+json" | jq '.'
  exit 0
fi

if [ "$1" == "list" ]
then
  curl -kisS "https://registry:5000/v2/$2/tags/list" \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json"
  exit 0
fi

if [ "$1" == "digest" ]
then
  curl -kIsS "https://registry:5000/v2/$2/manifests/$3" \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    | tr -d '\r' | sed -En 's/docker-content-digest: (.+)/\1/p'
  exit 0
fi

if [ "$1" == "delete" ]
then
  curl -kisS "https://registry:5000/v2/$2/manifests/$3" \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    -X DELETE
  exit 0
fi

#!/bin/bash
set -e

UNAME="..."
UPASS="..."
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME}'", "password": "'${UPASS}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
NAMESPACES=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/namespaces/ | jq -r '.namespaces|.[]')
echo $NAMESPACES
REPO_LIST=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/?page_size=8 | jq -r '.results|.[]|.name')

for i in ${REPO_LIST}
do
  IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${i}/tags/?page_size=8 | jq -r '.results|.[]|.name')
  for j in ${IMAGE_TAGS}
  do
    IMAGE_LIST="${IMAGE_LIST} ${UNAME}/${i}:${j}"
  done
done

for i in ${IMAGE_LIST}
do
  echo ${i}
done

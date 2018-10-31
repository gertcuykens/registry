#!/bin/bash
# GO111MODULE=on go mod vendor
# go build -mod=vendor
# go build -o main; ./main

GOOS=linux go build -tags 'netgo noplugin' -ldflags '-d -s -w -extldflags "-static"' -a -o main
docker build -t gertcuykens/test . # --target root
# docker run -it --rm gertcuykens/test
# docker push gertcuykens/test

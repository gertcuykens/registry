#!/bin/bash
GO111MODULE=on go mod vendor
docker build -t registry:5000/test . --target root
docker push regsitry:5000/test
# docker run -it --rm registry:5000/test

# docker build -t registry:5000/test . --target debug --build-arg TOKEN=""
# docker run -it --rm \
#     -v $(GOPATH):/go \
#     -w $(subst $(GOPATH),/go,$(CURDIR)) \
#     -p 2345:2345 \
#     --security-opt apparmor=unconfined \
#     --cap-add SYS_PTRACE \
#     --privileged \
#     registry:5000/test ash

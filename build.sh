#!/bin/sh

set -e -x

docker build --pull \
  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
  --build-arg VCS_REF=`git rev-parse --short HEAD` \
  -t vaple/phpcodesniffer:19.10 .

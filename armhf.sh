#! /bin/sh

# This script is used to build the armhf variant of Wharfie and uses the
# appropriate version of the armhf-alpine container as a base. It must be
# executed on an arm device with a running Docker service which has already
# been authenticated to Docker Hub via `docker login`

REPO=${1:-garrettheaver/armhf-wharfie}
BASE=${2:-container4armhf/armhf-alpine}

# line up the files
sed -e 's|FROM .*:|FROM '"$BASE"':|g' Dockerfile > Dockerfile.arm

# trigger the build
docker build --rm --tag="$REPO" --file="Dockerfile.arm" .
docker push "$REPO"


#! /bin/sh

# This script is used to build the armhf variant of Wharfie and uses the
# appropriate version of the armhf-alpine container as a base. It must be
# executed on an arm device with a running Docker service which has already
# been authenticated to Docker Hub via `docker login`

# line up the files
cp Dockerfile dockerfile.x86
sed -i -e 's/FROM alpine:/FROM container4armhf\/armhf-alpine:/g' Dockerfile

# trigger the build and push
docker build --rm --tag garrettheaver/armhf-wharfie .
docker push garrettheaver/armhf-wharfie

# cleanup
mv dockerfile.x86 Dockerfile


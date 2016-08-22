#! /bin/sh

# line up the files
cp Dockerfile dockerfile.x86
sed -i -e 's/FROM alpine:/FROM container4armhf\/armhf-alpine:/g' Dockerfile

# trigger the build and push
docker build --tag garrettheaver/armhf-wharfie
docker push garrettheaver/armhf-wharfie

# cleanup
mv dockerfile.x86 Dockerfile


FROM alpine:3.4

# bootstrap pkgs
RUN apk update \
  && apk add ca-certificates openssh-client git

COPY ./wharfie /bin
ENTRYPOINT ["/bin/wharfie"]


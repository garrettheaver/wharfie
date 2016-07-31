#! /bin/sh

# check args
if [ "$#" -ne 2 ]; then
  echo "usage: $0 <repository> <executable>"
  exit 1
fi

# check if git needs ssh
if [ ${1:0:4} = "git@" ]; then
  apk add openssh-client && mkdir ~/.ssh
  ssh-keyscan -H github.com >> ~/.ssh/known_hosts
  cat /etc/ssh/config >> ~/.ssh/config
fi

# bootstrap container
git clone "$1" /opt && \
  chmod +x "/opt/$2" && \
  eval "/opt/$2"


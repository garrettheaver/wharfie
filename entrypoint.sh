#! /bin/sh

# log out the start time
echo "entrypoint: `date -u \"+%Y-%m-%d %H:%M:%S\"` UTC"

# check correct args
if [ "$#" -ne 2 ]; then
  echo "usage: ./entrypoint.sh <source> <script>"
  exit 1
fi

# initial container startup
if [ ! -d "/opt/.git" ]; then

  # check if git needs ssh
  if [ ${1:0:4} = "git@" ]; then
    apk add openssh-client && mkdir -p ~/.ssh
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts
    cat /etc/ssh/config >> ~/.ssh/config
  fi

  # first clone
  git clone "$1" /opt

else

  # only pull required
  git -C /opt pull origin

fi

# bootstrap container
chmod +x "/opt/$2" && \
  eval "/opt/$2"


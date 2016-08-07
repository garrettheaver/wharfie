#! /bin/sh

# check correct args
if [ "$#" -ne 2 ]; then
  echo "usage: <source> <script>"
  exit 1
fi

# blank log line between starts
if [ -d "/opt/.git" ]; then
  printf "\n"
fi

# log out the start time of the container
echo "entrypoint: `date -u \"+%Y-%m-%d %H:%M:%S\"` UTC"

# initial container startup
if [ ! -d "/opt/.git" ]; then

  # check if git needs ssh
  if [ ${1:0:4} = "git@" ]; then
    apk add openssh-client && mkdir -p ~/.ssh
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts
    cat /etc/ssh/config >> ~/.ssh/config
  fi

  # first clone
  echo "git: clone $1"
  git clone "$1" /opt

else

  # simple update required
  echo "git: pull `git config --get remote.origin.url`"
  git -C /opt pull origin

fi

# bootstrap container
echo "entrypoint: exec $2"
chmod +x "/opt/$2" && \
  eval "/opt/$2"


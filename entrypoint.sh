#! /bin/sh

# check correct args
if [ "$#" -ne 2 ]; then
  echo "usage: <repo> <script>"
  exit 1
fi

# useful log info
echo "wharfie: $1, $2"

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

  # simple update required
  git -C /opt pull origin

fi

# bootstrap container
chmod +x "/opt/$2" && \
  eval "/opt/$2"


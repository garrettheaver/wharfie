# Wharfie
Rather than building a new docker image and redeploying every time you make a code change, Wharfie fetches the latest code from Git on start, loads it into your container at */opt* and executes a given filename to bootstrap the container. In other words: 1) git commit, 2) git push, 3) docker restart.

## Basic Usage
The Wharfie container is built on Alpine Linux and it's entrypoint expects two arguments

1. The git repository from which you want to pull code (*https* and *git@* protocols supported)
2. The name of the executable within the repo to invoke after cloning

Example:
```shell
docker run -d garrettheaver/wharfie https://github.com/<user>/<repo>.git bootstrap.sh
```

The executable file you specify (*bootstrap.sh* above) is responsible for installing any additional packages required by the container (via *apk add ...*) and then starting your application.

## Private Repositories
If you want to pull from a private GitHub repository (*git@*) then you'll want to mount a docker volume (a single file) containing the appropriate SSH key. This should be mounted at /etc/ssh/github.key

Example:
```shell
docker run -d -v ~/.ssh/github.key:/etc/ssh/github.key:ro garrettheaver/wharfie git@github.com/<user>/<repo>.git bootstrap.sh
```


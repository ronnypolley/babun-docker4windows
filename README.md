# babun-docker4windows

The work for this script is mostly based on [babun-docker](https://github.com/tiangolo/babun-docker). 

## Description

This is a fix allowing the use of [Docker for Windows](https://docs.docker.com/docker-for-windows/) from [Babun](http://babun.github.io) based on the idea used in [babun-docker](https://github.com/tiangolo/babun-docker).

If your're still using [Docker Toolbox](https://www.docker.com/toolbox) than you should use [babun-docker](https://github.com/tiangolo/babun-docker).

The main problem using docker from babun is running in a non-tty environment and there for does not supprt the _interactive_ mode of docker. The script will make use of [winpty](https://github.com/rprichard/winpty) to permit docker calls like:

```
docker run -it -v ubuntu:latest /bin/bash
```

The setup script will install a function called `docker` which just calls the normal docker program using winpty as a prefix.

# Prerequisite

1. Install [Docker for Windows](https://docs.docker.com/docker-for-windows/) 
2. Install [Babun](http://babun.github.io)


# Installation

```bash
curl -s https://raw.githubusercontent.com/ronnypolley/babun-docker4windows/master/setup.sh | source /dev/stdin
```

Check that the installation was succesfully:

```bash
which docker
```

This should be the function from [babun-docker.sh](bin/babun-docker.sh).



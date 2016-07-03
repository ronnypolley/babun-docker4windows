#! /bin/bash

# Fix for Docker and Docker Toolbox in Babun
if [[ -z "$docker_bin" ]] ; then
	docker_bin=$(which docker) ;
fi
# we just prefix the docker command with the console.exe from winpty
function docker {
	winpty $docker_bin $@
}

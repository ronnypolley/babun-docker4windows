#! /bin/bash

#*******************************************************************************
# Copyright (c) 2016 Ronny Polley
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
# Ronny Polley - main contributor
#******************************************************************************/


# get the location of the docker binary
docker_bin=$(which docker) ;

# we just prefix the docker command with the console.exe from winpty
function docker {
	winpty $docker_bin $@
}

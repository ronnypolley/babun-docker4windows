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


# winpty version
winpty_version="0.4.0"

# winpty name
winpty_name="winpty-${winpty_version}-cygwin-2.5.2-ia32"

# Specific file name
winpty_filename="${winpty_name}.tar.gz"

# winpty URL
winpty_url="https://github.com/rprichard/winpty/releases/download/${winpty_version}/${winpty_filename}"

# babun-docker repo
babun_docker_repo='https://github.com/ronnypolley/babun-docker4windows.git'

# put current folder on the stack
pushd . > /dev/null

# Directory in where to put Winpty
winpty_dir="$HOME/.winpty"

# Create the local .winpty directory
if [[ ! -d $winpty_dir ]] ; then
   mkdir -p $winpty_dir ;
fi

# Enter the .winpty directory to download winpty
cd $winpty_dir
if [[ ! -f winpty.exe ]] ; then
   # Remove old files
   rm -rf ./*
   # Download winpty
   wget -O - $winpty_url | tar xvz 
   # Move the tar contents to the current directory
   mv $winpty_name/bin/* ./
   # Remove untar-ed directory
   rm -rf $winpty_name
   # Make winpty executable
   chmod 777 $winpty_dir/*
   # write version to directory
   echo $winpty_version > version
fi
# add winpty path to the PATH variable
export PATH="$PATH:$winpty_dir"


# Set up babun-docker4windows
# Directory in where to put babun-docker4windows
babun_docker4windows_dir="$HOME/.babun-docker4windows"

if [[ ! -d $babun_docker4windows_dir ]] ; then
   git clone $babun_docker_repo $babun_docker4windows_dir
fi
cd $babun_docker4windows_dir
source 'bin/babun-docker.sh'

babun_docker_setup_str="source '$babun_docker4windows_dir/setup.sh'"

# Set up setup on start for bash if needed
if [[ -f $HOME/.bashrc ]] ; then
	if [[ -z $(grep "$babun_docker_setup_str" $HOME/.bashrc) ]] ; then
	  echo $babun_docker_setup_str >> $HOME/.bashrc ;
	fi
fi

# Set up setup on start for Zsh
if [[ -f $HOME/.zshrc ]] ; then
  if [[ -z $(grep "$babun_docker_setup_str" $HOME/.zshrc) ]] ; then
		echo $babun_docker_setup_str >> $HOME/.zshrc ;
	fi
fi

# Setup update
function babun-docker4windows-update {
	# save working directory
	pushd $(pwd)
	echo "Updating babun-docker4windows"
	cd $babun_docker4windows_dir
	git pull
	source ./setup.sh
	popd
}

popd > /dev/null

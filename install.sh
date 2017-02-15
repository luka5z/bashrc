#!/bin/bash

# BEFORE YOU RUN:
# Remember to backup your files:
#  - ~/.bashrc
#  - ~/.bash_aliases
#  - ~/.bash_settings
#  - ~/.bash_variables
#  - ...
# 
# Install script makes a copy before it creates a symbolic link, but
# if commands would be run twice, latter execution will overwrite initial 
# backup.

# Set environment by:
#  - installing Bash settings
#  - installing Powerline prompt
#  - adding Git aliases


SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function make_link() {
    file=$1

    if [ -f "${SCRIPTDIR}/${file}" ]; then
        ln -b -s "${SCRIPTDIR}/${file}" "${HOME}"
    fi
}

make_link .bashrc
make_link .bash_aliases 
make_link .bash_settings
make_link .bash_variables

# Git
. ./git-aliases/git-aliases.sh

# Powerline
./install-powerline/install-powerline.sh

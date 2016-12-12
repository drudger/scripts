#!/bin/bash
# 
# First pass at a way to customize new vagrant box with dotfiles from Github.
#
# The script checks if certain programs are available on the machine. If they
# aren't, they are added to the list of programs passed to the package manager
# specific installation script.

if [ $# -eq 0 ]; then
    echo "Usage: check_installs.sh <distro>"
else

    INSTALL_LIST=''

    if ! type git > /dev/null 2>&1; then
        echo "Git not found. Adding to list of installs."
        INSTALL_LIST+="git "
    else
        echo "Git found. Moving on."
    fi

    if ! type vim > /dev/null 2>&1; then
        echo "Vim not found. Adding to list of installs."
        INSTALL_LIST+="vim "
    else
        echo "Vim found. Moving on."
    fi

    if ! type tmux > /dev/null 2>&1 ; then
        echo "tmux not found. Adding to list of installs."
        INSTALL_LIST+="tmux "
    else
        echo "tmux found. Moving on."
    fi

    ./${1}.sh $INSTALL_LIST
fi

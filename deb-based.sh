#!/bin/bash
#
# All-in-one script for customizing new vagrant box environment with dotfiles
# from Github. 
#
# Will eventually be refactored for various distros.
#

# Move to user's home directory
cd ~/

# Check which programs are installed and which need to be.
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

echo ""

# Install needed programs.
echo "Ubuntu Installation
"

if [ -z $INSTALL_LIST ]; then
    echo "Nothing to install. Moving on.
    "
else    
    sudo apt-get -y install $INSTALL_LIST
fi

# Clone dot files
git clone https://github.com/drudger/dotfiles.git
cd dotfiles

# Install vim plugins and delete unneeded files
./install_vim_plugins.sh

# Copy dotfiles into home directory and source
cp ~/dotfiles/.* ~/
source ~/.bashrc

# Cleanup
cd ..
rm -rf dotfiles

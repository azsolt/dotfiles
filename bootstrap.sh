#!/usr/bin/env bash

die() {
    echo $1
    exit
}

if [ $USER == root ]; then
    die "bootstrap.sh: do not run as root (sudo)"
fi

oh_my_zsh() {
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
}

install_apps="
    git
    python-pip
    terminator
"

for app in $install_apps
do 
    echo "Installing $app..."
    sudo apt-get install -y $app
done

sudo apt-get autoremove -y
oh_my_zsh

# clone azsolt/dotfiles and run install.sh
if which git > /dev/null; then
    if [ ! -d ~/.dotfiles ]; then
        git clone https://github.com/azsolt/dotfiles.git ~/.dotfiles

        if [ -d ~/.dotfiles ]; then
            source ~/.dotfiles/install.sh
        else
            die "Failed to clone azsolt/dotfiles repository"
        fi
    fi
else
    die "Git was not installed, </3 check errors and try again"
fi

# install pip packages
if ! which pip > /dev/null; then
    die "Pip not installed"
fi
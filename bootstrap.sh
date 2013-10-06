#!/usr/bin/env bash

user=$SUDO_USER

do_user() {
    # run as current logged in user
    sudo -u $user $1
}

die() {
    echo $1
    exit
}

oh_my_zsh() {
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
}

if [ $USER != root ]; then
    die "bootstrap.sh must run as root"
fi

install_apps="
    git
    python-pip
    terminator
"

for app in $install_apps
do 
    echo "Installing $app..."
    apt-get install -y $app
done

apt-get autoremove -y

oh_my_zsh

# clone azsolt/dotfiles and run install.sh
if which git > /dev/null; then
    if [ ! -d ~/.dotfiles ]; then
        do_user "git clone https://github.com/azsolt/dotfiles.git ~/.dotfiles"

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
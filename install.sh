#!/usr/bin/env bash

function do_install() {
    # copy all files from config to ~/.config
    rsync -av ~/.dotfiles/config/* ~/.config

    # link every .symlink file into ~
    for source in `find ~/.dotfiles -maxdepth 2 -name \*.symlink.sh`
    do
        dest="$HOME/.`basename $source .symlink.sh`"

        if [ -f $dest ]; then
            mv $dest $dest\.backup
            echo "backing up existing $dest"
        fi

        rm -rf $dest
        ln -s $source $dest
        echo "installed $dest"
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    do_install
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        do_install
    fi
fi

unset do_install

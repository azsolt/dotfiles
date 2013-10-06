#!/usr/bin/env bash

function do_install() {
    # copy all files from config to ~/.config
    rsync -av config/* ~/.config
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

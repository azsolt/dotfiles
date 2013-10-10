#!/usr/bin/env bash

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

echo "azsolt dotfiles installed :)"

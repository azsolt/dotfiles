#!/usr/bin/env bash

# copy all files from config to ~/.config
echo "Copying configuration files..."
rsync -av ~/.dotfiles/config/* ~/.config
echo "==="

# link every .symlink file into ~
for source in `find ~/.dotfiles -maxdepth 2 -name \*.symlink.sh`
do
    dest="$HOME/.`basename $source .symlink.sh`"

    if [ -f $dest ]; then
        mv $dest $dest\.backup
        echo "Backing up your current $dest to $dest.backup"
    fi

    rm -rf $dest
    ln -s $source $dest
    echo "Linked $dest to $source"
    echo "==="
done

echo "Dotfiles installed :)"

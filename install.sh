#!/usr/bin/env bash

die() {
    echo $1
    exit
}

if [ $USER == root ]; then
    die "bootstrap.sh: do not run as root (sudo)"
fi

# installing environment apps

install_apps="
    chromium-browser
    git 
    python-pip 
    terminator
"

echo "Installing apps $install_apps"
sudo apt-get install -y $install_apps
echo "==="

# cleaning
echo "Cleaning..."
sudo apt-get autoremove -y
echo "==="

# install pip packages
if ! which pip > /dev/null; then
    die "Pip not installed"
fi

echo "Installing oh-my-zsh..."
# install oh-my-zsh, zsh (shell)
curl -sL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
echo "==="

# clone azsolt/dotfiles
if which git > /dev/null; then
    if [ ! -d ~/.dotfiles ]; then
        echo "Cloning git repository..."
        git clone https://github.com/azsolt/dotfiles.git ~/.dotfiles
        echo "==="
    fi
else
    die "Git was not installed, </3 check for errors and try again"
fi

# install dotfiles
if [ -d ~/.dotfiles ]; then
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
else
    die "Failed to clone azsolt/dotfiles repository"
fi
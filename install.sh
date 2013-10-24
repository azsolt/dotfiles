#!/usr/bin/env bash

# folders
app_dir=~/Applications

if [ ! -d $app_dir ]; then
    mkdir -p $app_dir
fi
# =====================================================================================

# functions
die() {
    echo $1
    exit
}
# =====================================================================================

if [ $USER == root ]; then
    die "install.sh: do not run as root (sudo)"
fi

cd ~

# installing environment apps

install_apps="
    chromium-browser
    dkms
    git
    python-dev
    python-pip
    terminator
    zsh
    xclip
    nodejs
    ruby1.9.1
"

# repos
sudo add-apt-repository ppa:chris-lea/node.js

echo "Installing apps $install_apps"
sudo apt-get update
sudo apt-get install -y $install_apps
echo "==="
# =====================================================================================

# cleaning
echo "Cleaning..."
sudo apt-get autoremove -y
echo "==="
# =====================================================================================

# install oh-my-zsh, zsh (shell)
echo "Installing oh-my-zsh..."
curl -sL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
echo "==="
# =====================================================================================

# install pip packages
sudo pip install virtualenvwrapper
# =====================================================================================

# install node packages
sudo npm install -g bower
sudo npm install -g coffee-script

# install gems
sudo gem install compass

# =====================================================================================

# if this was curl install, we must clone our repo
if [ ! -d ~/.dotfiles ]; then
    echo "Cloning git repository..."
    git clone https://github.com/azsolt/dotfiles.git ~/.dotfiles
    echo "==="
fi
# =====================================================================================

# dropbox
echo "Installing Dropbox..."
    ~/.dotfiles/bin/dropbox start -i
echo "==="
# =====================================================================================

# sublime-text
if [ ! -d $app_dir/sublime ]; then
echo "Installing Sublime Text 3..."
    curl -sL http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3047_x64.tar.bz2 | tar xj
    mv sublime_text_3 $app_dir/sublime
echo "==="
fi
# =====================================================================================

# copy all files from ~/.dotfiles/config to ~/.config
echo "Copying configuration files..."
rsync -av ~/.dotfiles/config/* ~/.config
echo "==="
# =====================================================================================

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
# =====================================================================================

echo "Dotfiles installed :)"

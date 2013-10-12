#!/usr/bin/env bash

# folders
dropbox_dir=~/Dropbox
app_dir=~/Applications
# =====================================================================================

# functions
die() {
    echo $1
    exit
}
# =====================================================================================

if [ $USER == root ]; then
    die "bootstrap.sh: do not run as root (sudo)"
fi

cd ~

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
# =====================================================================================

# cleaning
echo "Cleaning..."
sudo apt-get autoremove -y
echo "==="
# =====================================================================================

# install oh-my-zsh, zsh (shell)
if ! which zsh > /dev/null; then
    echo "Installing oh-my-zsh..."
    curl -sL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
    echo "==="
fi
# =====================================================================================

# install pip packages
if ! which pip > /dev/null; then
    die "Pip not installed"
fi
# =====================================================================================

# if this was curl install, we must clone our repo
if [ ! -d ~/.dotfiles ]; then
    echo "Cloning git repository..."
    git clone git@github.com:azsolt/dotfiles.git ~/.dotfiles
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
    ln -s $app_dir/Sublime/sublime_text ~/.dotfiles/bin/subl
echo "==="
fi
# =====================================================================================

# copy all files from ~/.dotfiles/config to ~/.config
echo "Copying configuration files..."
rsync -av ~/.dotfiles/config/* ~/.config
echo "==="
# =====================================================================================

# link every .symlink file into ~
for source in `find $DOT -maxdepth 2 -name \*.symlink.sh`
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
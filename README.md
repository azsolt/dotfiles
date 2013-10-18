azsolt dotfiles
=
My environment personalization files a.k.a. dotfiles. You can use them if you wish.

In the process of making my own dotfiles I used these as references:

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [holman/dotfiles](https://github.com/holman/dotfiles)

## Installation

If you want to install directly from my repository - remember that this will not allow customization of any sort (like installed apps, pip packages, etc) - then run the command below:

``curl -L https://raw.github.com/azsolt/dotfiles/master/install.sh | bash``

If you want to customize what applications to install, you must first [fork this repository](https://github.com/azsolt/dotfiles/fork) into your GitHub account. Clone it to your machine, make any changes and push to your repo.
After that just run the above command pointing to your own bootstrap.sh raw url.

## Components 

* __*.symlink.sh__ file inside ~/.dotfiles will get symlinked into ~
* __*.source.sh__ file inside ~/.dotfiles will get sourced by __.zshrc__
* __/config__ gets copied into __~/.config__
* __/exports__ must be manually imported into correct application

## Installed applications

* chromium-browser
* dkms
* git
* python-dev
* python-pip
* terminator
* zsh
* oh-my-zsh
* xclip
* nodejs
* ruby
* dropbox
* sublime-text

#### Packages

Pip
* virtualenvwrapper

Node
* coffee-script
* bower

Gems
* compass
* sass





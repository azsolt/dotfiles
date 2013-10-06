azsolt dotfiles
=
My environment personalization files a.k.a. dotfiles. You can use them if you wish.

In the process of making my own dotfiles I used these as references:

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [holman/dotfiles](https://github.com/holman/dotfiles)

## Installation

Install zsh shell from [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

``curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash``

Then run the following:

```
git clone https://github.com/azsolt/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

## Components 

Files

* __*.symlink.sh__ file inside ~/.dotfiles will get symlinked into ~
* __*.source.sh__ file inside ~/.dotfiles will get sourced by __.zshrc__

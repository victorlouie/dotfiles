# My dotfiles

## Requirements

Ensure you have the following installed

### Git

### Brew

### Stow
```sh
$ brew install stow
```

## Installation

Check out the `dotfiles` repository into your $HOME directory using `git`

> [!WARNING]
> There might be a chicken/egg condition because of the order of execution with pulling down the `dotfiles` repository

```sh
cd
git clone git@github.com/victorlouie/dotfiles.git

cd dotfiles
stow .
```

```sh
mkdir -p ~/git/victorlouie
cd ~/git/victorlouie
git clone git@github.com:victorlouie/dotfiles.git

ln -nsf ~/git/victorlouie/dotfiles ~/.dotfiles

cd dotfiles
stow -t ~ -v .
```

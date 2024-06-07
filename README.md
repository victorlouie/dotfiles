# My dotfiles

## Requirements

Ensure you have the following installed

### Git
```sh
$ brew install git
```

### Homebrew
```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

[HomeBrew](https://brew.sh/) is a package management system for MacOS.


### Stow
```sh
$ brew install stow
```

## Installation

Check out the `dotfiles` repository into your $HOME directory using `git` into a `.dotfiles` directory

```sh
git clone git@github.com/victorlouie/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

stow --no-folding .
```

### MacOS
```sh
brew install \
    bat
    eza
    fd
    fzf
    font-hack-nerd-font
    font-meslo-lg-nerd-font
    git-delta
    starship
    thefuck
    tlrc
    zoxide
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
```

> [!NOTE]
> Default behaviour is link directories. `--no-folding` creates the directories and links the files instead of directories


## Useful Commands
```sh
# Simulate stowing with verbose output
stow --no-folding -nv .

# Simulate unstowing with verbose output
stow --no-folding -Dnv .
```

## Ideas 🤔
- Separate the MacOS specific files out into a difference repository
- `stow` with directory path



# Brew Install and Configuration

`brew` is a package manager for MacOS and Linux

## Install brew

Install `brew`
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install `brew` packages 

```sh
brew bundle install 
```

> [!NOTE]
> brew installs the non GNU version of tar, sed and other utilities
> 
> This is not in the current Brewfile 

## Rebuild Brewfile
```sh
brew bundle dump
```


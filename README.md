# dotfiles

My dotfiles in nix

---

# Install

Tested on:
- [AlmaLinux 9](https://almalinux.org/)
- [Rocky Linux 9](https://rockylinux.org/)

# Requirements

## Redhat

### System Installs
```sh
sudo dnf install -y \
    alsa-sof-firmware \
    epel-release \
    gnome-extensions-app \
    gnome-shell-extension-dash-to-dock \
    gnome-tweaks
```

### System Tools
```sh
sudo dnf install -y \
    container-tools \
    git \
    fastfetch \
    make \
    xsel
```

## Nix

### Install Nix

`Nix` is installed using the installer from [Determinate Systems](https://determinate.systems) because the official installer needs SELinux disabled on RedHat.

Note: flakes are enabled by default when using the Determinate Systems installer

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate

# Source the nix daemon (or open a new shell)  
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

```sh
# Test flake
nix run nixpkgs#hello
```

### Install home-manager

`home-manager` is installed with the unstable version to match the version coming from `Determinate Systems`

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

# Update

Applying new changes

```sh
cd nix-config
make
```

## Change shell

```sh
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
```


# Troubleshooting

```sh
# Rollback
# Note: Internet is required (unless I figure it out)
home-manager generations
/nix/store/p9cjq................xyz-home-manager-generation/activate
```


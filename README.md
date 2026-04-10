# Personal Dotfiles

This repository contains my personal configuration for my macOS system and programs.

## Preview

![Dark and Light version](https://github.com/user-attachments/assets/1dccb5f2-0022-453d-a9c5-ba0d2e476243)

## Install

```sh
curl -fsSL https://bensadik.net/dotfiles | bash
```

## Tech
- [Nix](https://nixos.org/) - Nix is a powerful package manager for Unix systems that makes package management reliable and reproducible.
- [nix-darwin](https://github.com/LnL7/nix-darwin) - nix-darwin is a set of tools for using Nix as a standalone macOS package manager.
- [Homebrew](https://brew.sh/) - Homebrew is a package manager for macOS.
- [home-manager](https://github.com/nix-community/home-manager) - Manage user configuration using Nix.

## Infisical

Machine secrets are pulled from Infisical and loaded by Zsh.

1. Fill in `programs/infisical/infisical.conf`
2. Apply the dotfiles: `sudo darwin-rebuild switch --flake ~/dotfiles#$USER`
3. Authenticate with `infisical login` if you are not using `INFISICAL_MACHINE_TOKEN`
4. Pull secrets with `infisync`

```sh
INFISICAL_MACHINE_PROJECT_ID="<project-id>"
INFISICAL_MACHINE_ENV="prod"
INFISICAL_MACHINE_PATH="/"

# Optional for self-hosted Infisical
# INFISICAL_MACHINE_DOMAIN="https://infisical.example.com/api"

# Optional for non-interactive auth
# INFISICAL_MACHINE_TOKEN="<machine-identity-or-service-token>"
```

Pulled secrets are written to `~/.local/state/infisical/machine.env` with `0600` permissions and auto-loaded in new shells.

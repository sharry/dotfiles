#!/usr/bin/env bash
set -euo pipefail

# ─── Sharry's macOS bootstrap ────────────────────────────────────────
# Installs Nix (Determinate), then applies the full darwin config.
# Usage:  curl -fsSL <raw-url>/install.sh | bash
#    or:  ./install.sh

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/sharry/dotfiles.git"

# ─── Colors ──────────────────────────────────────────────────────────
red()   { printf '\033[1;31m%s\033[0m\n' "$*"; }
green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
bold()  { printf '\033[1m%s\033[0m\n' "$*"; }

# ─── Rosetta 2 (Apple Silicon) ───────────────────────────────────────
if [ "$(uname -m)" = "arm64" ] && ! /usr/bin/pgrep -q oahd; then
  bold "Installing Rosetta 2..."
  softwareupdate --install-rosetta --agree-to-license
  green "Rosetta 2 installed."
fi

# ─── Nix (Determinate installer) ────────────────────────────────────
if ! command -v nix &>/dev/null; then
  bold "Installing Nix via Determinate installer..."
  curl --proto '=https' --tlsv1.2 -sSf -L \
    https://install.determinate.systems/nix | sh -s -- install
  # Source nix in the current shell
  if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
    . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
  fi
  green "Nix installed."
else
  green "Nix already installed."
fi

# ─── Clone dotfiles ─────────────────────────────────────────────────
if [ ! -d "$DOTFILES_DIR" ]; then
  bold "Cloning dotfiles..."
  if ! command -v git &>/dev/null; then
    nix-shell -p git --run "git clone $DOTFILES_REPO $DOTFILES_DIR"
  else
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
  green "Dotfiles cloned."
else
  green "Dotfiles already present at $DOTFILES_DIR."
fi

# ─── First nix-darwin build (bootstrap) ──────────────────────────────
bold "Building and applying nix-darwin configuration..."
cd "$DOTFILES_DIR"

# On a fresh machine, darwin-rebuild won't exist yet.
# Use nix run to bootstrap nix-darwin for the first time.
if ! command -v darwin-rebuild &>/dev/null; then
  bold "Bootstrapping nix-darwin (first run)..."
  nix run nix-darwin/master -- switch --flake ".#$(whoami)" --impure
else
  sudo --preserve-env=EMAIL,FULLNAME \
    darwin-rebuild switch --flake ".#$(whoami)" --impure
fi

green "Configuration applied successfully!"
bold ""
bold "Next steps:"
bold "  Run 'renix' to re-apply after any changes"

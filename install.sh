#!/usr/bin/env bash
set -euo pipefail

# ─── Sharry's macOS bootstrap ────────────────────────────────────────
# Installs Nix (Determinate), syncs secrets from Infisical, then applies
# the full darwin config — one command to reproduce the entire machine.
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

cd "$DOTFILES_DIR"

# ─── Age key ────────────────────────────────────────────────────────
AGE_KEY_DIR="$HOME/.config/sops/age"
AGE_KEY_FILE="$AGE_KEY_DIR/keys.txt"

if [ ! -f "$AGE_KEY_FILE" ]; then
  bold "Generating age encryption key..."
  mkdir -p "$AGE_KEY_DIR"
  if ! nix-shell -p age --run "age-keygen -o '$AGE_KEY_FILE'"; then
    red "Failed to generate age key."
    exit 1
  fi
  chmod 600 "$AGE_KEY_FILE"
  if [ ! -s "$AGE_KEY_FILE" ]; then
    red "Age key file was not created correctly."
    exit 1
  fi
  green "Age key generated at $AGE_KEY_FILE"

  # Extract public key and update .sops.yaml
  if ! AGE_PUB=$(nix-shell -p age --run "age-keygen -y '$AGE_KEY_FILE'"); then
    red "Failed to extract age public key."
    exit 1
  fi
  if [ -z "$AGE_PUB" ]; then
    red "Age public key is empty."
    exit 1
  fi
  AGE_PUB_ESCAPED=$(printf '%s' "$AGE_PUB" | sed 's/[&|\\]/\\&/g')
  bold "Updating .sops.yaml with public key: $AGE_PUB"
  sed -i '' "s|age1[a-z0-9]*|$AGE_PUB_ESCAPED|" .sops.yaml
  green ".sops.yaml updated."
else
  green "Age key already exists."
fi

# ─── Infisical login & secrets sync ─────────────────────────────────
# The infisical.conf is in the repo (symlinked later by home-manager),
# but we can source it directly for bootstrap.
INFISICAL_CONF="$DOTFILES_DIR/programs/infisical/infisical.conf"

bold "Logging into Infisical..."
nix-shell -p infisical --run "infisical login"
green "Infisical authenticated."

bold "Syncing secrets from Infisical..."
nix-shell -p infisical -p sops -p jq -p yq-go --run "
  set -euo pipefail
  set -a; source '$INFISICAL_CONF'; set +a

  json=\$(infisical export \
    --silent \
    --format=json \
    --projectId \"\$INFISICAL_MACHINE_PROJECT_ID\" \
    --env \"\${INFISICAL_MACHINE_ENV:-macbook}\" \
    --path \"\${INFISICAL_MACHINE_PATH:-/}\" \
    \${INFISICAL_MACHINE_DOMAIN:+--domain \"\$INFISICAL_MACHINE_DOMAIN\"} \
    \${INFISICAL_MACHINE_TOKEN:+--token \"\$INFISICAL_MACHINE_TOKEN\"})

  required='["email","fullname","whisper_hostname","ssh_id_ed25519_personal","ssh_id_ed25519_personal_pub","ssh_id_ed25519_work","ssh_id_ed25519_work_pub","ssh_id_ed25519_secure","ssh_id_ed25519_secure_pub"]'
  missing=\$(jq -r --argjson required \"\$required\" '(\$required - ([.[].key | ascii_downcase] | unique))[]?' <<<\"\$json\")
  if [ -n \"\$missing\" ]; then
    printf 'Missing required build secrets in Infisical:\n%s\n' \"\$missing\" >&2
    exit 1
  fi

  echo \"\$json\" | jq '[.[] | {(.key | ascii_downcase): .value}] | add // {}' | yq -P > secrets/secrets.yaml
  sops encrypt -i secrets/secrets.yaml
"
green "Secrets synced and encrypted."

# ─── First nix-darwin build (bootstrap) ──────────────────────────────
bold "Building and applying nix-darwin configuration..."

if ! command -v darwin-rebuild &>/dev/null; then
  bold "Bootstrapping nix-darwin (first run)..."
  nix run nix-darwin/master -- switch --flake ".#$(whoami)"
else
  sudo darwin-rebuild switch --flake ".#$(whoami)"
fi

green "Configuration applied successfully!"
bold ""
bold "Next steps:"
bold "  • Run 'renix' to re-apply after any changes"
bold "  • Run '~/dotfiles/bin/sync-secrets' to update secrets from Infisical"

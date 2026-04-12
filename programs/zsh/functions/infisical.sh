load_infisical_machine_config() {
  local config_file="@configHome@/infisical/infisical.conf"

  if [ -f "$config_file" ]; then
    set -a
    . "$config_file"
    set +a
  fi
}

load_infisical_machine_env() {
  local env_file="@stateHome@/infisical/machine.env"

  if [ -f "$env_file" ]; then
    set -a
    . "$env_file"
    set +a
  fi
}

infisync() {
  emulate -L zsh
  setopt pipefail

  local config_file="@configHome@/infisical/infisical.conf"
  local state_dir="@stateHome@/infisical"
  local env_file="$state_dir/machine.env"
  local tmp_file
  local old_umask
  local -a command

  mkdir -p "$state_dir"
  load_infisical_machine_config

  if [ -z "$INFISICAL_MACHINE_PROJECT_ID" ]; then
    printf 'Set INFISICAL_MACHINE_PROJECT_ID in %s\n' "$config_file"
    return 1
  fi

  command=(
    infisical export
    --silent
    --format=dotenv
    --projectId "$INFISICAL_MACHINE_PROJECT_ID"
    --env "${INFISICAL_MACHINE_ENV:-macbook}"
    --path "${INFISICAL_MACHINE_PATH:-/}"
  )

  if [ -n "$INFISICAL_MACHINE_DOMAIN" ]; then
    command+=(--domain "$INFISICAL_MACHINE_DOMAIN")
  fi

  if [ -n "$INFISICAL_MACHINE_TOKEN" ]; then
    command+=(--token "$INFISICAL_MACHINE_TOKEN")
  fi

  old_umask=$(umask)
  umask 077
  tmp_file=$(mktemp "$state_dir/machine.env.tmp.XXXXXX") || {
    umask "$old_umask"
    return 1
  }
  umask "$old_umask"

  if ! "$command[@]" >| "$tmp_file"; then
    rm -f "$tmp_file"
    return 1
  fi

  mv "$tmp_file" "$env_file"
  load_infisical_machine_env
}

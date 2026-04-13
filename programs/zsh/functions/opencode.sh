# Calculate opencode port based on git repo or current directory
opencode_port() {
  # Check if in a git submodule first
  local superproject=$(git rev-parse --show-superproject-working-tree 2>/dev/null)

  if [ -n "$superproject" ]; then
    # In a submodule - use parent repo's .git
    local git_dir=$(cd "$superproject" && git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null)
  else
    # Normal git repo
    local git_dir=$(git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null)
  fi

  if [ -n "$git_dir" ]; then
    # Hash the .git directory path
    echo $((0x$(echo -n "$git_dir" | md5 | cut -c1-8) % 10000 + 50000))
  else
    # Fallback: hash current directory path
    echo $((0x$(echo -n "$PWD" | md5 | cut -c1-8) % 10000 + 50000))
  fi
}

# Export port as environment variable for nvim
export_opencode_port() {
  export OPENCODE_PORT=$(opencode_port)
}

# Zellij does not reliably proxy the terminal theme/color queries OpenCode uses
# for light/dark auto detection, so derive the mode before launching.
opencode_detect_theme_mode() {
  if [ "$(uname -s)" = "Darwin" ]; then
    if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
      echo dark
    else
      echo light
    fi
    return 0
  fi

  return 1
}

opencode_refresh_theme_mode() {
  local state_home="${XDG_STATE_HOME:-$HOME/.local/state}"
  local kv_dir="$state_home/opencode"
  local kv_file="$kv_dir/kv.json"
  local tmp_file
  local mode

  command -v jq >/dev/null 2>&1 || return
  mkdir -p "$kv_dir" || return
  tmp_file=$(mktemp) || return

  if [ -n "$ZELLIJ" ] && mode=$(opencode_detect_theme_mode); then
    if [ -f "$kv_file" ]; then
      if jq --arg mode "$mode" '
        del(.theme_mode) |
        if (.opencode_theme_mode_workaround? == "zellij-auto") or (.theme_mode_lock? == null) then
          .theme_mode_lock = $mode |
          .opencode_theme_mode_workaround = "zellij-auto"
        else
          .
        end
      ' "$kv_file" > "$tmp_file"; then
        mv "$tmp_file" "$kv_file"
      else
        rm -f "$tmp_file"
      fi
    else
      if jq -n --arg mode "$mode" '{theme_mode_lock: $mode, opencode_theme_mode_workaround: "zellij-auto"}' > "$tmp_file"; then
        mv "$tmp_file" "$kv_file"
      else
        rm -f "$tmp_file"
      fi
    fi
    return
  fi

  if [ ! -f "$kv_file" ]; then
    rm -f "$tmp_file"
    return
  fi

  if jq '
    del(.theme_mode) |
    if .opencode_theme_mode_workaround? == "zellij-auto" then
      del(.theme_mode_lock, .opencode_theme_mode_workaround)
    else
      .
    end
  ' "$kv_file" > "$tmp_file"; then
    mv "$tmp_file" "$kv_file"
  else
    rm -f "$tmp_file"
  fi
}

opencode() {
  opencode_refresh_theme_mode
  command opencode "$@"
}

o() {
  local port=$(opencode_port)
  opencode --port "$port"
}

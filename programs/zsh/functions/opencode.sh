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

opencode() {
  command opencode "$@"
}

o() {
  local port=$(opencode_port)
  opencode --port "$port"
}

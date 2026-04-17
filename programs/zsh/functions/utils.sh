macos_theme() {
  if [[ $(defaults read ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle 2>/dev/null) = Dark ]]; then
    echo 'Dark'
  else
    echo 'Light'
  fi
}

unjwt() {
  local output header claims

  output=$(jwt decode "$(pbpaste)")
  header=$(echo "$output" | awk 'c==1{print} /^----/{c++}' | tail -r | tail -n +4 | tail -r)
  claims=$(echo "$output" | awk 'c==2{print} /^----/{c++}')
  echo "$header" | jq
  echo
  echo "$claims" | jq
}

play() {
	mpv --vo=kitty --profile=sw-fast --really-quiet "$@"
}

killport() {
  if [ -z "${1:-}" ]; then
    echo "Usage: killport <port>"
    return 1
  fi

  local port="$1"
  local pids_output pid
  local -a pids

  if ! command -v lsof >/dev/null; then
    echo "lsof not found. Please install lsof."
    return 1
  fi

  pids_output=$(lsof -i tcp:"$port" -sTCP:LISTEN -t 2>/dev/null)

  if [ -z "$pids_output" ]; then
    echo "No process found on port $port"
    return 1
  fi

  pids=("${(@f)pids_output}")
  for pid in "${pids[@]}"; do
    echo "Stopping process $pid on port $port"
    kill "$pid" 2>/dev/null || true
  done

  sleep 1
  for pid in "${pids[@]}"; do
    if kill -0 "$pid" 2>/dev/null; then
      echo "Process $pid did not exit after SIGTERM, sending SIGKILL"
      kill -9 "$pid"
    fi
  done
}

ghostty_tab_name() {
  emulate -L zsh

  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || true

  if [[ -n $repo_root ]]; then
    print -r -- "${repo_root:t}"
  elif [[ $PWD == $HOME ]]; then
    print -r -- "~"
  else
    print -r -- "${PWD:t}"
  fi
}

ghostty_tab_name_update() {
  emulate -L zsh

  [[ $TERM_PROGRAM == ghostty ]] || return 0
  command -v osascript >/dev/null 2>&1 || return 0

  local current_title desired_title

  current_title=$(
    osascript <<'EOF'
tell application "Ghostty"
  if running is false then
    return ""
  end if

  return name of selected tab of front window
end tell
EOF
  ) || return 0

  current_title=${current_title//$'\r'/}
  [[ -z ${current_title//[[:space:]]/} ]] || return 0

  desired_title=$(ghostty_tab_name)
  [[ -n $desired_title ]] || return 0

  osascript - "$desired_title" >/dev/null 2>&1 <<'EOF'
on run argv
  set tabTitle to item 1 of argv

  tell application "Ghostty"
    if running is false then
      return
    end if

    perform action ("set_tab_title:" & tabTitle) on focused terminal of selected tab of front window
  end tell
end run
EOF
}

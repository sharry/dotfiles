zellij_tab_name_update() {
  [[ $ZELLIJ == 1 ]] || return 0

  local current_dir=$PWD
  if [[ $current_dir == $HOME ]]; then
    current_dir="~"
  else
    current_dir=${current_dir##*/}
  fi

  command nohup zellij action rename-tab "$current_dir" >/dev/null 2>&1 &!
}

#!/bin/sh

set -eu

theme_dir="@dataHome@/posting/themes"
theme_file="$theme_dir/catppuccin-auto.yml"

/bin/mkdir -p "$theme_dir"

if [ "$(/usr/bin/defaults read -g AppleInterfaceStyle 2>/dev/null || true)" = "Dark" ]; then
  primary="#89b4fa"
  secondary="#fab387"
  accent="#b4befe"
  background="#1e1e2e"
  surface="#181825"
  error="#f38ba8"
  success="#a6e3a1"
  warning="#f9e2af"
  dark="true"
  description="Catppuccin Auto, currently following macOS Dark mode with the Mocha palette"
else
  primary="#1e66f5"
  secondary="#fe640b"
  accent="#7287fd"
  background="#eff1f5"
  surface="#e6e9ef"
  error="#d20f39"
  success="#40a02b"
  warning="#df8e1d"
  dark="false"
  description="Catppuccin Auto, currently following macOS Light mode with the Latte palette"
fi

tmp_file=$(/usr/bin/mktemp "$theme_dir/catppuccin-auto.yml.XXXXXX")
trap '/bin/rm -f "$tmp_file"' EXIT HUP INT TERM

cat > "$tmp_file" <<EOF
name: catppuccin-auto
primary: '$primary'  # buttons, fixed table columns
secondary: '$secondary'  # method selector, some minor labels
accent: '$accent'  # header text, scrollbars, cursors, focus highlights
background: '$background' # background colors
surface: '$surface'  # panels, etc
error: '$error'  # error messages
success: '$success'  # success messages
warning: '$warning'  # warning messages
dark: $dark

author: Youssef Ben Sadik
description: '$description'
homepage: https://github.com/sharry/posting-catppuccin
EOF

if [ -f "$theme_file" ] && /usr/bin/cmp -s "$tmp_file" "$theme_file"; then
  /bin/rm -f "$tmp_file"
else
  /bin/mv "$tmp_file" "$theme_file"
fi

trap - EXIT HUP INT TERM

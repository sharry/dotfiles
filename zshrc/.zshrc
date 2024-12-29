# Yazi wrapper that changes the current working directory to the one specified by yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias v="nvim"
alias c="clear"
alias renix="darwin-rebuild switch --flake ~/dotfiles/nix/darwin#sharry"

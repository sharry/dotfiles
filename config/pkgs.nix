{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fd
		jqp
		nil
		fzf
		atac
		deno
		dblab
		serpl
		gnupg
		cargo
		jdk23
		devenv
		podman
		ffmpeg
		jwt-cli
		lazygit
		lazysql
		ripgrep
		python39
		nodejs_22
		fastfetch
		lazydocker
		plistwatch # MacOS only
		imagemagick
		claude-code
		neovim-remote
		podman-compose
		nixfmt-rfc-style
	];
}

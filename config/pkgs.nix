{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fd
		jqp
		nil
		fzf
		_7zz
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
		nodejs_22
		fastfetch
		lazydocker
		plistwatch # MacOS only
		imagemagick
		claude-code
		podman-compose
		nixfmt-rfc-style
	];
}

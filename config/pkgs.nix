{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fd
		jqp
		nil
		fzf
		dysk
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
		opencode
		nodejs_22
		fastfetch
		secretspec
		gemini-cli
		lazydocker
		plistwatch # MacOS only
		imagemagick
		claude-code
		podman-compose
		nixfmt-rfc-style
	];
}

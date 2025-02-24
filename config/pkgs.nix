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
		lazydocker
		plistwatch # MacOS only
		imagemagick
		podman-compose
		nixfmt-rfc-style
	];
}

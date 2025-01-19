{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fd
		nil
		fzf
		atac
		deno
		dblab
		gnupg
		podman
		ffmpeg
		jwt-cli
		lazygit
		lazysql
		ripgrep
		nodejs_22
		lazydocker
		imagemagick
		podman-compose
		nixfmt-rfc-style
	];
}

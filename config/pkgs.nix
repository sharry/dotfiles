{ pkgs, ... }:
{
	home.packages = with pkgs; [
		fd
		nil
		fzf
		atac
		deno
		gtop
		dblab
		gnupg
		podman
		ffmpeg
		jwt-cli
		lazygit
		ripgrep
		nodejs_22
		lazydocker
		imagemagick
		podman-compose
		nixfmt-rfc-style
	];
}

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
		ffmpeg
		jwt-cli
		lazygit
		ripgrep
		nodejs_22
		imagemagick
		nixfmt-rfc-style
	];
}

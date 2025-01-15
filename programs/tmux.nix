{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		prefix = "C-a";
		mouse = true;
		keyMode = "vi";
		baseIndex = 1;
		clock24 = true;
		plugins = with pkgs; [
			tmuxPlugins.catppuccin
		];
	};
}

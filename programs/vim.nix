{
  programs.nvf = {
    
    enable = true;

    settings.vim = {

      keymaps = [
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = ":Neotree toggle<CR>";
        }
		{
			key = "<leader><space>";
			mode = "n";
			silent = true;
			action = ":Telescope git_files<CR>";
		}
      ];
      
      theme = {
        enable = true;
        transparent = true;
        name = "catppuccin";
        style = "mocha";
      };

      ui = {
        colorizer.enable = true;
      };

      filetree.neo-tree = {
        enable = true;
      };

	  statusline.lualine = {
		enable = true;
	  };

	  telescope.enable = true;

      assistant.copilot.enable = true;

	  comments.comment-nvim.enable = true;

	  useSystemClipboard = true;

    };
  };
}

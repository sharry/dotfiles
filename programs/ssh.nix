{
	programs.ssh = {

		enable = true;

		matchBlocks = {

			# Personal GitHub
			"github.com" = {
				hostname = "github.com";
				user = "git";
				identityFile = "~/.ssh/id_ed25519_personal";
				extraOptions = {
					AddKeysToAgent = "yes";
					UseKeychain = "yes";
				};
			};

			# Work GitHub
			"github-work" = {
				hostname = "github.com";
				user = "git";
				identityFile = "~/.ssh/id_ed25519_work";
				extraOptions = {
					AddKeysToAgent = "yes";
					UseKeychain = "yes";
				};
			};

		};
	};
}

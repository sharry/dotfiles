let
	vars = import ../vars.nix;
in
{
	programs.git = {
		enable = true;
		userName = "${vars.personal.firstName} ${vars.personal.lastName}";
		userEmail = vars.personal.email;
		ignores = [
			".DS_Store"
			"*.*~"
		];
		extraConfig = {
			pull.rebase = true;
			init.defaultBranch = "main";
			push.autoSetupRemote = true;
		};
	};
}

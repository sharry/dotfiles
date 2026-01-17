let
	vars = import ../vars.nix;
in
{
	programs.git = {
		enable = true;
		settings = {
			pull.rebase = true;
			init.defaultBranch = "main";
			push.autoSetupRemote = true;
			user = {
				email = vars.personal.email;
				name = "${vars.personal.firstName} ${vars.personal.lastName}";
			};
		};
		ignores = [
			".DS_Store"
			"*.*~"
		];
	};
}

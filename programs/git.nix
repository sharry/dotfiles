{
	programs.git = {
		enable = true;
		userName = "Youssef Ben Sadik";
		userEmail = "youssef@bensadik.net";
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

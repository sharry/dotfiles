{
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      pull.rebase = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        email = builtins.getEnv "EMAIL";
        name = builtins.getEnv "FULLNAME";
      };
    };
    ignores = [
      ".DS_Store"
      "*.*~"
    ];
  };
}

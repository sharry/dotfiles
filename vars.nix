rec {
  personal = {
    user = "momo";
    system = "aarch64-darwin";
    home = "/Users/${personal.user}";
    dotfilesPath = "${personal.home}/dotfiles";
    secretive = {
      socket = "${personal.home}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      signingPubKey = "${personal.home}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/3859d406657af602a1659b787d06f5c7.pub";
    };
  };
}

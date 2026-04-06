{ pkgs, ... }:
let
  javaDebugExtension = pkgs.vscode-extensions.vscjava.vscode-java-debug;
  javaTestExtension = pkgs.vscode-extensions.vscjava.vscode-java-test;
  springBootTools = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "vscode-spring-boot";
    version = "2.1.1";

    src = pkgs.fetchurl {
      url = "https://open-vsx.org/api/VMware/vscode-spring-boot/${version}/file/VMware.vscode-spring-boot-${version}.vsix";
      hash = "sha256-OHfljk/IJEqC1lPsYa6w0hYp6kvgmBHxkdafgcnb3Vw=";
    };

    dontUnpack = true;
    nativeBuildInputs = [ pkgs.unzip ];

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/vscode/extensions/vmware.vscode-spring-boot"
      unzip -qq "$src" -d extracted
      cp -R extracted/extension/. "$out/share/vscode/extensions/vmware.vscode-spring-boot/"
      runHook postInstall
    '';
  };
in
{
  programs.neovim = {
    enable = true;
    extraPackages = [
      pkgs.jdk21
      pkgs.jdt-language-server
      javaDebugExtension
      javaTestExtension
      springBootTools
    ];
  };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
    JAVA_DEBUG_EXTENSION_PATH = "${javaDebugExtension}/share/vscode/extensions/vscjava.vscode-java-debug";
    JAVA_TEST_EXTENSION_PATH = "${javaTestExtension}/share/vscode/extensions/vscjava.vscode-java-test";
    SPRING_BOOT_EXTENSION_PATH = "${springBootTools}/share/vscode/extensions/vmware.vscode-spring-boot";
  };
}

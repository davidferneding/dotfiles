{ pkgs, local, ... }:

{
  home.username = local.username;
  home.homeDirectory = local.homeDirectory;
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.dotnet-sdk_10
    pkgs.go
    pkgs.nodejs_24
    pkgs.rustup
    pkgs.temurin-bin
    pkgs.clojure
  ];
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    JAVA_HOME = "${pkgs.temurin-bin.home}";
  };
}

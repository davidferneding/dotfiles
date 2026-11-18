{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk_10
    go
    nodejs_24
    rustup
    temurin-bin
    clojure
    babashka
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    JAVA_HOME = "${pkgs.temurin-bin.home}";
  };
}

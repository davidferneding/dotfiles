{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.dotnet-sdk_10
    pkgs.go
    pkgs.nodejs_24
    pkgs.rustup
    pkgs.temurin-bin
    pkgs.clojure
    pkgs.oh-my-zsh
    pkgs.zsh-powerlevel10k
    pkgs.tmux
    pkgs.neovim
    pkgs.lf
    pkgs.babashka
    pkgs.gum
    pkgs.fzf
    pkgs.tree-sitter
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.gh
    pkgs.glab
    pkgs.ripgrep
    pkgs.pay-respects
    pkgs.monaspace
    pkgs.nerd-fonts.monaspace
    pkgs.sketchybar-app-font
  ];
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    JAVA_HOME = "${pkgs.temurin-bin.home}";
  };
}

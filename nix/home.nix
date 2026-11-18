{ config, pkgs, ... }:

let
  link = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/${path}";
in
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
  home.file = {
    ".zshrc".source = link ".zshrc";
    ".tmux.conf".source = link ".tmux.conf";
    ".ideavimrc".source = link ".ideavimrc";
  };

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    JAVA_HOME = "${pkgs.temurin-bin.home}";
  };
}

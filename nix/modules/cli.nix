{ config, pkgs, ... }:

let
  link = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/${path}";
in
{
  home.packages = with pkgs; [
    # productivity
    fzf
    lf
    pay-respects
    ripgrep
    tmux

    # dev tools
    gh
    glab
    kubectl
    kubernetes-helm
    neovim
    tree-sitter

    # pretty
    gum
    oh-my-zsh
    zsh-powerlevel10k
  ];

  home.file = {
    ".zshrc".source = link ".zshrc";
    ".tmux.conf".source = link ".tmux.conf";
  };
}

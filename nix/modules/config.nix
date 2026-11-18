{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    monaspace
    nerd-fonts.monaspace
    sketchybar-app-font
  ];

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/.ideavimrc";
}

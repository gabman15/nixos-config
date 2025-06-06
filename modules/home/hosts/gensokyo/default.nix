{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    antimicrox
    cantata
    ymuse
    ludusavi
  ];

  custom.home.suites.graphical.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.dev.enable = true;
  custom.home.behavior.xdg.enable = lib.mkForce false;
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    desktop = null;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = null;
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = null;
    templates = null;
    videos = "${config.home.homeDirectory}/Videos";
    createDirectories = true;
  };
  custom.home.programs.rofi.enable = true;
  custom.home.programs.backgrounder.enable = true;

  stylix = lib.recursiveUpdate ((import ../../../nixos/themes/common) pkgs) ((import ../../../nixos/themes/${config.custom.home.opts.hostname}) pkgs);

  home.stateVersion = "24.11";
}

{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    antimicrox
    cantata
    ymuse
    ludusavi
    vesktop
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
  custom.home.programs.sway.enable = true;
  custom.home.programs.sway.sys-swaylock = true;
  custom.home.programs.sway.sys-kitty = true;
  wayland.windowManager.sway.package = null;
  custom.home.programs.waybar.enable = true;
  custom.home.opts.stylix = true;
  custom.home.opts.screens = {
    "Acer Technologies XV272U 0x1121BA45" = {
      sway = {
        position = "0 0";
        resolution = "2560x1440@143.999Hz";
      };
    };
    "Dell Inc. DELL E2414H VJH96522A4TU" = {
      sway = {
        position = "2560 0";
        resolution = "1920x1080@60.000Hz";
        transform = "270";
      };
    };
  };

  stylix = lib.recursiveUpdate ((import ../../../nixos/themes/common) pkgs) ((import ../../../nixos/themes/${config.custom.home.opts.hostname}) pkgs);

  home.stateVersion = "24.11";
}

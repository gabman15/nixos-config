{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    antimicrox
    cantata
    ymuse
    ludusavi
    vesktop
    discord
    librewolf
    signal-desktop
    pass
  ];

  custom.home.suites.graphical.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.dev.enable = true;

  custom.home.programs.rofi.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.sway.enable = true;
  custom.home.programs.waybar.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.gnupg.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.mpd.enable = true;

  custom.themes.enable = true;
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
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "wlr" ];
      };
    };
  };

  home.stateVersion = "25.05";
}

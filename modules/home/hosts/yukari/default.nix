{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    signal-desktop
    vesktop
    pass
    ymuse
  ];


  custom.home.programs.sway.enable = true;
  custom.home.programs.waybar.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.mpv.remote = true;
  custom.home.programs.gnupg.enable = true;
  custom.home.programs.rofi.enable = true;

  custom.home.suites.dev.enable = true;
  custom.home.suites.graphical.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.mpd.mpd-host = "nitori";

  custom.themes.enable = true;
  custom.home.opts.stylix = true;
  custom.home.opts.screens = {
    "BOE 0x095F Unknown" = {
      sway = {
        position = "0 0";
        resolution = "2256x1504@59.999Hz";
      };
    };
  };
  stylix.targets = {
    rofi.enable = true;
  };

  age.secrets.backgrounder-config.file = ../../../../secrets/backgrounder-config.age;

  home.stateVersion = "24.11";
}

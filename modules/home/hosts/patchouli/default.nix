{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulsemixer
    cifs-utils
    jetbrains.idea-oss
    librewolf
  ];


  custom.themes.enable = true;
  custom.home.opts.stylix = true;
  custom.home.suites.graphical.enable = true;
  custom.home.suites.dev.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.mpd.mpd-host = "nitori";
  custom.home.programs.rmpc.badterm = true;
  custom.home.programs.gnupg.enable = true;
  custom.home.programs.sway.enable = true;
  custom.home.programs.sway.modifier = "Mod2";
  custom.home.programs.waybar.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.winclip.enable = true;
  custom.home.opts.screens = {};
  home.stateVersion = "24.11";
}

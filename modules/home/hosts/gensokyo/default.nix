{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    antimicrox
    ymuse
  ];

  custom.home.suites.graphical.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.dev.enable = true;
  custom.home.behavior.xdg.enable = lib.mkForce false;
  custom.home.programs.rofi.enable = true;

  stylix = ((import ../../../nixos/themes/gensokyo) pkgs);

  home.stateVersion = "24.11";
}

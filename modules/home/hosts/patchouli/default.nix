{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  custom.home.suites.dev.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.mpd.mpd-host = "nitori";

  home.stateVersion = "24.11";
}

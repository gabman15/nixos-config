{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulsemixer
  ];

  custom.home.suites.dev.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.mpd.mpd-host = "nitori";
  custom.home.programs.rmpc.badterm = true;

  home.stateVersion = "24.11";
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  custom.home.programs.bash.enable = true;
  custom.home.programs.direnv.enable = true;
  custom.home.programs.albumart.enable = true;
  custom.home.programs.albumart.mpd-host = "nitori";
  custom.home.programs.mpv.enable = true;

  home.stateVersion = "24.11";
}

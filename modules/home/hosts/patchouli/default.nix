{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  custom.home.programs.bash.enable = true;
  custom.home.programs.direnv.enable = true;
  custom.home.programs.albumart.enable = true;
  custom.home.programs.albumart.mpd-host = "nitori";
  
  home.stateVersion = "24.11";
}

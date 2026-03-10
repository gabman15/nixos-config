{ pkgs, ... }:

{
  custom.home.programs.bash.zfs = true;
  custom.home.programs.tmux.enable = true;
  home.stateVersion = "25.05";
}

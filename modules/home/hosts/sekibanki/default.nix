{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nfs-utils
  ];
  custom.home.programs.tmux.enable = true;
  home.stateVersion = "26.05";
}

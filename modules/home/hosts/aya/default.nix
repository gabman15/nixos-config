{ pkgs, ... }:

{
  home.packages = with pkgs; [
    makemkv
  ];
  custom.home.programs.tmux.enable = true;
  home.stateVersion = "26.05";
}

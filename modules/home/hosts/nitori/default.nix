{ pkgs, ... }:

{
  custom.home.programs.bash.zfs = true;
  custom.home.suites.dev.enable = true;
  custom.home.programs.emacs.minimal = true;
  home.stateVersion = "25.05";
}

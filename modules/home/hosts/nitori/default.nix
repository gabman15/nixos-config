{ pkgs, ... }:

{
  custom.home.programs.bash.zfs = true;
  custom.home.suites.dev.enable = true;
  home.stateVersion = "25.05";
}

{ pkgs, lib, ... }:

{
  # home.packages = with pkgs; [

  # ];
  custom.home.suites.mpd.enable = true;
  custom.home.behavior.xdg.enable = lib.mkForce false;

  home.stateVersion = "24.11";
}

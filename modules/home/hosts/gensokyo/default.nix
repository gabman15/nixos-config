{ pkgs, lib, ... }:

{
  # home.packages = with pkgs; [

  # ];

  custom.home.behavior.xdg.enable = lib.mkForce false;

  home.stateVersion = "24.11";
}

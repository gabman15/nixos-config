{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.themes;
in
  {
    options.custom.nixos.themes = {
      enable = mkEnableOption "theme for host";
    };

    config = mkIf cfg.enable {
      stylix = ((import ./${config.networking.hostName}) pkgs);
      #((import ./common) pkgs) //
    };
  }

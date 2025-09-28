{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.themes;
in
  {
    options.custom.nixos.themes = {
      enable = mkEnableOption "theme for host";
    };

    config = mkIf cfg.enable {
        custom.home.opts.stylix = true;
        stylix = ((import ./yukari) pkgs); #TEMP
      };
  }

{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.waybar;
in
  {
    options.custom.home.programs.waybar = {
      enable = mkEnableOption "waybar status bar";
    };

    config = mkIf cfg.enable {
      
      # ${config.custom.home.opts.hostname}
    };
  }

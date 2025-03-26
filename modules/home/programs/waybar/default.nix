{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.waybar;
in
  {
    options.custom.home.programs.waybar = {
      enable = mkEnableOption "waybar status bar";
    };

    config = mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        settings = {
          bar_top = {
            layer = "top";
            position = "top";
            height = 30;
            modules-left = [ "memory" "cpu" ];
          };
          bar_bottom = {
            layer = "bottom";
            position = "bottom";
            height = 30;
            modules-center = [ "sway/workspaces" ];
          };

          "sway/workspaces" = {
            disable-scroll = true;
          };
        };
      # ${config.custom.home.opts.hostname}
      };
    };
  }

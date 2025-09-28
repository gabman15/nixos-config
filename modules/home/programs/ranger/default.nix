{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.ranger;
in
  {
    options.custom.home.programs.ranger = {
      enable = mkEnableOption "ranger file explorer";
    };

    config = mkIf cfg.enable {
      programs.ranger = {
        enable = true;
        settings = {
          preview_images = true;
          preview_images_method = mkIf config.custom.home.programs.kitty.enable "kitty";
        };
        mappings = {
          "<C-d>" = "shell ${pkgs.dragon-drop}/bin/dragon-drop -a -x %p";
        };
      };      
    };
  }

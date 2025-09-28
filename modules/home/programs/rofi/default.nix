{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.rofi;
in
  {
    options.custom.home.programs.rofi = {
      enable = mkEnableOption "rofi";
    };

    config = mkIf cfg.enable {
      programs.rofi = {
        enable = true;
      };
    };
  }

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
        pass = {
          enable = true;
          extraConfig = ''
            default_user='gabman15'
            USERNAME_field='user'
          '';
        };
      };
    };
  }

{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.rofi;
in
  {
    options.custom.home.programs.rofi = {
      enable = mkEnableOption "rofi";
    };

    config = mkIf cfg.enable {
      home.file."${config.programs.rofi.configPath}".text =
      ''
        element-icon {
          size: 5.0ch;
        }
        listview {
          columns: 3;
        }
      '';
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

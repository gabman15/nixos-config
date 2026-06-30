{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.behavior.graphical-bootup;
in
  {
    options.custom.nixos.behavior.graphical-bootup = {
      enable = mkEnableOption "boot into graphical desktop";
      autostart-sway = mkOption {
        default = false;
        type = lib.types.bool;
      };
    };
    
    config = mkIf cfg.enable (mkIfElse cfg.autostart-sway
      {
        services.getty = {
          autologinUser = "lord_gabem";
          autologinOnce = true;
        };

        environment.loginShellInit = ''
          [[ "$(tty)" == /dev/tty1 ]] && sway
        '';
      }
      {
        programs.regreet.enable = true;
      }
    );
  }

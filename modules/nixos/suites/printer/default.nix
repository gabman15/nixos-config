{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.printer;
in
  {
    options.custom.nixos.suites.printer = {
      enable = mkEnableOption "Ability to use printers";
    };

    config = mkIf cfg.enable {
      users.users.lord_gabem.extraGroups = [ "lp" ];
    };
  }

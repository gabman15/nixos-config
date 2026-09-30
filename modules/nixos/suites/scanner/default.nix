{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.scanner;
in
  {
    options.custom.nixos.suites.scanner = {
      enable = mkEnableOption "Enables Sane for use with scanner";
    };

    config = mkIf cfg.enable {
      hardware.sane.enable = true;
    };
  }

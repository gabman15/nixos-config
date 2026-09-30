{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.drawing-tablet;
in
  {
    options.custom.nixos.suites.drawing-tablet = {
      enable = mkEnableOption "Enables open tablet driver for use with drawing tablets";
    };

    config = mkIf cfg.enable {
      hardware.opentabletdriver.enable = true;
    };
  }

{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.mavica-ingest;
in
  {
    options.custom.home.programs.mavica-ingest = {
      enable = mkEnableOption "importing photos from sony mavica camera";
    };

    config = mkIf cfg.enable {
      home.packages = [
        inputs.mavica-scripts.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      home.sessionVariables = {
        MAVICA_SCRIPTS_MAKE = "Sony";
        MAVICA_SCRIPTS_MODEL = "Mavica FD73";
        MAVICA_SCRIPTS_DEVICE = "/dev/disk/by-id/usb-TEACV0.0_TEACV0.0";
      };
    };
  }

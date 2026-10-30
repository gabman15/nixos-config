{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.bluetooth;
in
  {
    options.custom.nixos.suites.bluetooth = {
      enable = mkEnableOption "Enables bluetooth support for system";
    };

    config = mkIf cfg.enable {
      hardware.bluetooth.enable = true; # enables support for Bluetooth
      hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
      services.blueman.enable = true;
    };
  }

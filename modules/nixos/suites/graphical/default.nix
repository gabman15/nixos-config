{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.graphical;
in
  {
    options.custom.nixos.suites.graphical = {
      enable = mkEnableOption "nixos opts for graphical pc";
    };
    
    config = mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      boot.loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };

      networking.networkmanager.enable = true;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
    };
  }

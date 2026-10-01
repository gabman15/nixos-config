{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.bootable;
in
  {
    options.custom.nixos.suites.bootable = {
      enable = mkEnableOption "nixos opts for bootable pc";
    };

    config = mkIf cfg.enable {
      boot.loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };
      boot.extraModprobeConfig = ''
        options cfg80211 ieee80211_regdom=US
      '';
    };
  }

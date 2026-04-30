{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.behavior.kernel-latest;
in
  {
    options.custom.nixos.behavior.kernel-latest = {
      enable = mkEnableOption "use latest linux kernel";
    };
    
    config = mkIf cfg.enable {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
  }

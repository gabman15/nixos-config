{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.qemu;
in
  {
    options.custom.nixos.programs.qemu = {
      enable = mkEnableOption "qemu vm";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        qemu
      ];
    };
  }

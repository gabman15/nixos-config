{ config, lib, modulesPath, ... }:

with lib; let
  cfg = config.custom.nixos.hardware.dell-inspiron-15-7000;
in
  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    options.custom.nixos.hardware.dell-inspiron-15-7000 = {
      enable = mkEnableOption "dell inspiron 15 7000 hardware config";
    };

    config = mkIf cfg.enable {

    };
  }

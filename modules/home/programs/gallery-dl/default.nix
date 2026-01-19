{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.gallery-dl;
in
  {
    options.custom.home.programs.gallery-dl = {
      enable = mkEnableOption "gallery-dl tool";
    };

    config = mkIf cfg.enable {
      home.packages = [
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.gallery-dl
      ];
    };
  }

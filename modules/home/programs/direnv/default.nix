{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.direnv;
in
  {
    options.custom.home.programs.direnv = {
      enable = mkEnableOption "direnv";
    };

    config = mkIf cfg.enable {
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
  }

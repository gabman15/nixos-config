{ lib, config, outputs, pkgs, ... }:

with lib; let
  cfg = config.custom.home.programs.emacs;
in
  {
    options.custom.home.programs.emacs = {
      enable = mkEnableOption "emacs";
      dev = mkEnableOption "developer emacs config";
    };

    config = mkIf cfg.enable {
      
      home.packages = mkIfElse cfg.dev
        [ outputs.packages.${pkgs.stdenv.hostPlatform.system}.emacs-dev ]
        [ outputs.packages.${pkgs.stdenv.hostPlatform.system}.emacs ];
    };
  }

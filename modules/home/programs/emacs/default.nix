{ lib, config, outputs, pkgs, ... }:

with lib; let
  cfg = config.custom.home.programs.emacs;
  mkIfElse = p: yes: no: mkMerge [
    (mkIf p yes)
    (mkIf (!p) no)
  ];
in
  {
    options.custom.home.programs.emacs = {
      enable = mkEnableOption "emacs";
      minimal = mkEnableOption "minimal emacs config";
    };

    config = mkIf cfg.enable {
      
      home.packages = mkIfElse cfg.minimal
        [ outputs.packages.${pkgs.system}.emacs-minimal ]
        [ outputs.packages.${pkgs.system}.emacs ];
    };
  }

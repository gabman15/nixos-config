{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.suites.dev;
in
  {
    options.custom.home.suites.dev = {
      enable = mkEnableOption "suite of programs for development";
    };

    config = mkIf cfg.enable {
      custom.home.programs.emacs.dev = true;
      custom.home.programs.direnv.enable = true;
    };
  }

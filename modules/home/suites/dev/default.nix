{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.suites.dev;
in
  {
    options.custom.home.suites.dev = {
      enable = mkEnableOption "suite of programs for development";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        ripgrep
        fzf
      ];

      custom.home.programs.direnv.enable = true;
    };
  }

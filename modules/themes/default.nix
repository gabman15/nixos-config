{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.themes;
in
  {
    options.custom.themes = {
      enable = mkEnableOption "theme for host";
    };

    config = mkIf cfg.enable {
      stylix = lib.recursiveUpdate ((import ./common) pkgs)
        ((import ./${config.custom.opts.hostname}) pkgs);
    };
  }

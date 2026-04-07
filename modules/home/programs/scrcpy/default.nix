{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.scrcpy;
in
  {
    options.custom.home.programs.scrcpy = {
      enable = mkEnableOption "scrcpy phone mirroring";
    };

    config = mkIf cfg.enable {
      home.packages = [
        (pkgs.writeShellScriptBin "scrcpy" ''
        ${pkgs.scrcpy}/bin/scrcpy --render-driver=opengl "$@"
        '')
      ];
    };
  }

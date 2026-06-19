{ pkgs, lib, config, inputs, ... }:

with lib; let
  cfg = config.custom.home.programs.mpv;
in
  {
    options.custom.home.programs.mpv = {
      enable = mkEnableOption "mpv video player";
      remote = mkEnableOption "mpv remote node";
      downmix = mkOption {
        default = true;
        type = lib.types.bool;
      };
    };

    config = mkIf cfg.enable {
      programs.mpv = {
        enable = true;

        scripts = mkMerge [
          (mkIf cfg.remote [
            inputs.mpv-remote-node.packages.${pkgs.stdenv.hostPlatform.system}.mpv-remote-script
          ])
          (mkIf cfg.downmix [
            inputs.jbwar22-mpv-scripts.packages.${pkgs.stdenv.hostPlatform.system}.downmix
          ])
          []
        ];
        config = {
          # script-opts = "mpvremote.";
          screenshot-directory = "/home/${config.home.username}/pictures/screenshots/mpv";
        };
      };
    };
  }

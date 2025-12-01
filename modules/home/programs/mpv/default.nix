{ pkgs, lib, config, inputs, ... }:

with lib; let
  cfg = config.custom.home.programs.mpv;
in
  {
    options.custom.home.programs.mpv = {
      enable = mkEnableOption "mpv video player";
      remote = mkEnableOption "mpv remote node";
    };

    config = mkIf cfg.enable {
      programs.mpv = {
        enable = true;

        scripts = mkMerge [
          (mkIf cfg.remote [
            inputs.mpv-remote-node.packages.${pkgs.stdenv.hostPlatform.system}.mpv-remote-script
          ])
          [
            inputs.jbwar22-mpv-scripts.packages.${pkgs.stdenv.hostPlatform.system}.downmix
          ]
        ];
        config = {
          # script-opts = "mpvremote.";
          screenshot-directory = "/home/${config.home.username}/pictures/screenshots/mpv";
        };
      };
    };
  }

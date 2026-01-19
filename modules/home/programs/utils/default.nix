{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.utils;
in
  {
    options.custom.home.programs.utils = {
      enable = mkEnableOption "util programs with no config";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        fastfetch
        git
        git-crypt
        ripgrep
        fzf
        p7zip
        ffmpeg
        yt-dlp
        pulsemixer
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  }

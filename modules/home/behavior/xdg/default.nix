{ config, lib, ... }:

with lib; let
  cfg = config.custom.home.behavior.xdg;
in
  {
    options.custom.home.behavior.xdg = {
      enable = mkEnableOption "xdg";
    };

    config = mkIf cfg.enable {
      xdg.enable = true;
      xdg.userDirs = {
        enable = true;
        desktop = null;
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = null;
        pictures = "${config.home.homeDirectory}/pictures";
        publicShare = null;
        templates = null;
        videos = "${config.home.homeDirectory}/videos";
        createDirectories = true;
      };
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "librewolf.desktop";
          "x-scheme-handler/http" = "librewolf.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";
          "x-scheme-handler/about" = "librewolf.desktop";
          "x-scheme-handler/unknown" = "librewolf.desktop";
        };
      };
    };
  }

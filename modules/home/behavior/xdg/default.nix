{ pkgs, config, lib, ... }:

with lib; let
  cfg = config.custom.home.behavior.xdg;
in
  {
    options.custom.home.behavior.xdg = {
      enable = mkEnableOption "xdg";
      defaultBrowser = mkOption {
        description = "default browser desktop file";
        type = types.str;
        default = "librewolf.desktop";
      };
    };

    config = mkIf cfg.enable {
      xdg.mime.enable = true;
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
          "application/pdf" = cfg.defaultBrowser;
          "application/x-extension-htm" = cfg.defaultBrowser;
          "application/x-extension-html" = cfg.defaultBrowser;
          "application/x-extension-shtml" = cfg.defaultBrowser;
          "application/x-extension-xht" = cfg.defaultBrowser;
          "application/x-extension-xhtml" = cfg.defaultBrowser;
          "application/xhtml+xml" = cfg.defaultBrowser;
          "text/html" = cfg.defaultBrowser;
          "x-scheme-handler/about" = cfg.defaultBrowser;
          "x-scheme-handler/http" = cfg.defaultBrowser;
          "x-scheme-handler/https" = cfg.defaultBrowser;
          "x-scheme-handler/unknown" = cfg.defaultBrowser;
          "x-scheme-handler/discord-1216669957799018608" = "discord.desktop";
          "x-scheme-handler/discord-455712169795780630" = "discord.desktop";
          "x-scheme-handler/sgnl" = "signal.desktop";
          "x-scheme-handler/signalcaptcha" = "signal.desktop";
        };
      };
      xdg = {
        portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
          xdgOpenUsePortal = true;
          config = {
            sway.default   = [ "wlr" ];
            common.default = [ "wlr" ];
          };
        };
      };
    };
  }

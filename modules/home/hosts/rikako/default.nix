{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
  ];
  custom.home = {
    suites = {
      fonts.enable = true;
      mpd.enable = true;
    };
    programs = {
      sway.enable = true;
      backgrounder.enable = true;
      mpv.enable = true;
      mpv.remote = true;
      mpv.downmix = false;
      mpd.enable = true;
    };

    opts.screens = {
      "DP-3" = {
        output = {};
        workspace = "1";
      };
    };
  };
  wayland.windowManager.sway.config = {
    seat = {
      "*" = {
        hide_cursor = "100";
      };
    };
  };

  systemd.user.services.mpv = {
    Unit = {
      Description = "Start up mpv on boot";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = let
        app = pkgs.writeShellApplication {
          name = "mpv-remote-daemon";
          runtimeInputs = with pkgs; [ busybox ];
          text =
            ''
              ${config.programs.mpv.finalPackage}/bin/mpv --idle --fullscreen
            '';
        };
      in
        lib.getExe app;
    };
  };

  home.stateVersion = "25.11";
}

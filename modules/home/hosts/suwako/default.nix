{ lib, config, pkgs, ... }:

{
  custom.home = {
    suites.fonts.enable = true;
    programs.sway.enable = true;
    programs.backgrounder.enable = true;
    programs.mpv.enable = true;
    programs.mpv.remote = true;

    opts.screens = {
      "eDP-1" = {
        output = {
          disable = "";
        };
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

  home.stateVersion = "24.11";
}

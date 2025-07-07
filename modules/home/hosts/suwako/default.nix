{ lib, config, pkgs, ... }:

{
  custom.home.suites.graphical.enable = true;
  custom.home.programs.sway.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.mpv.remote = true;

  custom.home.opts.screens = {
    "eDP-1" = {
      sway = {
        disable = "";
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

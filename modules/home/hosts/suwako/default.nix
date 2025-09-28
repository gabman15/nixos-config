{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulsemixer
  ];

  custom.home.programs.sway.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.mpv.remote = true;

  age.secrets.backgrounder-config.file = ../../../../secrets/backgrounder-config.age;

  systemd.user.services.mpv = {
    Unit = {
      Description = "Start up mpv on boot";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.mpv}/bin/mpv --idle --fullscreen
      '';
    };
  };

  home.stateVersion = "24.11";
}

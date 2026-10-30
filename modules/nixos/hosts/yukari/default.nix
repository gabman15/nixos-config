{ config, pkgs, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.custom.opts.username}.extraGroups = [ "uinput" ];

  hardware.uinput.enable = true;

  custom.themes.enable = true;

  programs.captive-browser = {
    enable = true;
    interface = "wlp166s0";
  };

  custom.nixos = {
    programs = {
      steam.enable = true;
      vpn-namespace.enable = true;
      tailscale.enable = true;
    };
    hardware.framework-13.enable = true;
    suites = {
      graphical.enable = true;
      drawing-tablet.enable = true;
      bluetooth.enable = true;      
      nas-mounts = {
        enable = true;
        mounts = [
          {
            what = "nitori:/anime";
            where = "/mnt/anime";
            options = "noatime,noauto,nofail,_netdev";
          }
        ];
      };
    };
    behavior = {
      graphical-bootup.autostart-sway = true;
    };
  };

  system.stateVersion = "24.11";
}

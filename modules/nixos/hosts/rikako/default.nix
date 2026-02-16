{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "America/New_York";

  # For swaylock
  security.pam.services.swaylock = { };
  security.polkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lord_gabem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  boot.supportedFilesystems = [ "nfs" ];

  systemd.mounts = [
    {
      description = "nitori anime";
      what = "nitori:/anime";
      type = "nfs";
      where = "/mnt/anime";
      after = [ "tailscaled.service" ];
    }
  ];

  systemd.automounts = [
    {
      description = "Automount for nitori anime";
      where = "/mnt/anime";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "lord_gabem";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;

  custom.nixos.hardware.dell-optiplex-7060-micro.enable = true;

  custom.nixos.suites.graphical.enable = true;

  system.stateVersion = "25.11";
}

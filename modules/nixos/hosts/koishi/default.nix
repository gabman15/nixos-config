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
    linger = true;
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu";
        user = "lord_gabem";
      };
    };
  };

  systemd.mounts = let
    commonOpts = {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      after = [ "tailscaled.service" ];
    };
  in [
    (commonOpts // {
      description = "nitori anime";
      what = "nitori:/anime";
      where = "/mnt/anime";
    })
    (commonOpts // {
      description = "nitori music";
      what = "nitori:/music";
      where = "/mnt/music";
    })
    (commonOpts // {
      description = "nitori archive";
      what = "nitori:/archive";
      where = "/mnt/archive";
    })
  ];

  systemd.automounts = [
    {
      description = "Automount for nitori anime";
      where = "/mnt/anime";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
    {
      description = "Automount for nitori music";
      where = "/mnt/music";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
    {
      description = "Automount for nitori archive";
      where = "/mnt/archive";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
  ];

  boot.supportedFilesystems = [ "nfs" ];

  custom.themes.enable = true;

  services.tailscale.enable = true;

  custom.nixos.hardware.gigabyte-b650.enable = true;
  custom.nixos.suites.graphical.enable = true;
  custom.nixos.suites.nvidia.enable = true;

  system.stateVersion = "25.05";
}

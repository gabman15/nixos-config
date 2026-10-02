{ ... }:

{
  # For swaylock
  security.pam.services.swaylock = { };
  security.polkit.enable = true;

  systemd.mounts = let
    commonOpts = {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
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
      after = [ "tailscale-online.service" ];
      requires = [ "tailscale-online.service" ];
      wantedBy = [ "multi-user.target" ];
    }
    {
      description = "Automount for nitori music";
      where = "/mnt/music";
      after = [ "tailscale-online.service" ];
      requires = [ "tailscale-online.service" ];
      wantedBy = [ "multi-user.target" ];
    }
    {
      description = "Automount for nitori archive";
      where = "/mnt/archive";
      after = [ "tailscale-online.service" ];
      requires = [ "tailscale-online.service" ];
      wantedBy = [ "multi-user.target" ];
    }
  ];

  boot.supportedFilesystems = [ "nfs" ];
  custom.themes.enable = true;

  programs.nix-ld.enable = true;

  custom.nixos = {
    programs = {
      vpn-namespace.enable = true;
      steam.enable = true;
      tailscale.enable = true;
    };
    hardware.gigabyte-b650.enable = true;
    suites = {
      graphical.enable = true;
      noise-suppression.enable = true;
      drawing-tablet.enable = true;
      scanner.enable = true;
      printer.enable = true;
    };
    behavior.kernel-latest.enable = true;
    behavior.graphical-bootup.autostart-sway = true;
  };
  system.stateVersion = "25.05";
}

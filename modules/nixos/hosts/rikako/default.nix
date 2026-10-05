{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "nfs" ];

  systemd.mounts = [
    {
      description = "nitori anime";
      what = "nitori:/anime";
      type = "nfs";
      where = "/mnt/anime";
      after = [ "tailscaled.service" ];
    }
    {
      description = "nitori videos";
      what = "nitori:/archive/videos";
      type = "nfs";
      where = "/mnt/videos";
      after = [ "tailscaled.service" ];
    }
    {
      description = "nitori music";
      what = "nitori:/music";
      type = "nfs";
      where = "/mnt/music";
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
    {
      description = "Automount for nitori videos";
      where = "/mnt/videos";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
    {
      description = "Automount for nitori music";
      where = "/mnt/music";
      after = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
    }
  ];

  custom.nixos = {
    programs.tailscale.enable = true;
    hardware.dell-optiplex-7060-micro.enable = true;

    suites.graphical.enable = true;
  };

  system.stateVersion = "25.11";
}

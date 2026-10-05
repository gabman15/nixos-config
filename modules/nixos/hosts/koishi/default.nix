{ ... }:

{
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
      nas-mounts = {
        enable = true;
        mounts = [
          {
            what = "nitori:/anime";
            where = "/mnt/anime";
          }
          {
            what = "nitori:/music";
            where = "/mnt/music";
          }
          {
            what = "nitori:/archive";
            where = "/mnt/archive";
          }
        ];
      };
    };
    behavior.kernel-latest.enable = true;
    behavior.graphical-bootup.autostart-sway = true;
  };
  system.stateVersion = "25.05";
}

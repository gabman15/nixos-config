{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

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
        command = "${pkgs.sway}/bin/sway --unsupported-gpu";
        user = ${config.custom.opts.username};
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;

  custom.nixos.hardware.dell-inspiron-15-7000.enable = true;

  custom.nixos.suites.graphical.enable = true;
  # custom.nixos.suites.nvidia.enable = true;

  boot = {
    kernelParams = [
      "module_blacklist=i915"
    ];
  };

  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6; #BRUH
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  system.stateVersion = "24.11";
}

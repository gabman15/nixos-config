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

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "565.77";
      sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
      sha256_aarch64 = "sha256-LSAYUnhfnK3rcuPe1dixOwAujSof19kNOfdRHE7bToE=";
      openSha256 = "sha256-Fxo0t61KQDs71YA8u7arY+503wkAc1foaa51vi2Pl5I=";
      settingsSha256 = "sha256-VUetj3LlOSz/LB+DDfMCN34uA4bNTTpjDrb6C6Iwukk=";
      persistencedSha256 = "sha256-wnDjC099D8d9NJSp9D0CbsL+vfHXyJFYYgU3CwcqKww=";
    };
  };

  boot = {
    kernelParams = [
      "nvidia-drm.fbdev=1"
    ];
    blacklistedKernelModules = [ "nouveau" ];
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

  system.stateVersion = "25.05";
}

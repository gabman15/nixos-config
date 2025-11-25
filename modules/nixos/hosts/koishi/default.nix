{ lib, inputs, config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "America/New_York";

  # For swaylock
  security.pam.services.swaylock = { };
  security.polkit.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lord_gabem = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp"]; # Enable ‘sudo’ for the user.
    linger = true;
  };

  environment.systemPackages = with pkgs; [
    tailscale
    bottles
  ];

  custom.nixos.programs.steam.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
  #       user = "greeter";
  #     };
  #   };
  # };

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

  hardware.opentabletdriver.enable = true;
  hardware.sane.enable = true;
  custom.themes.enable = true;

  services.tailscale.enable = true;

  custom.nixos.programs.vpn-namespace.enable = true;

  custom.nixos.hardware.gigabyte-b650.enable = true;
  custom.nixos.suites.graphical.enable = true;
  custom.nixos.suites.nvidia.enable = true;
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia = with lib; let
  #   parsedDriverAttrs = pipe inputs.nixpkgs-unstable [
  #     (x: x + "/pkgs/os-specific/linux/nvidia-x11/default.nix")
  #     readFile
  #     (splitString "production = generic {")
  #     last
  #     (splitString "};")
  #     head
  #     trim
  #     (splitString "\n")
  #     (map (x: pipe x [
  #       trim
  #       (splitString " = ")
  #       (x: {
  #         name = head x;
  #         value = pipe x [
  #           last
  #           (removePrefix "\"")
  #           (removeSuffix "\";")
  #         ];
  #       })
  #     ]))
  #     listToAttrs
  #   ];
  # in {
  #   package = config.boot.kernelPackages.nvidiaPackages.mkDriver parsedDriverAttrs;
  #   open = false;

  #   modesetting.enable = true;
  #   powerManagement.enable = false;

  #   nvidiaSettings = true;
  # };
  # boot = {
  #   blacklistedKernelModules = [ "nouveau" "amdgpu" ];
  # };

  system.stateVersion = "25.05";
}

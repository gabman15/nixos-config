{ pkgs, ... }:

{
  imports =
    [
      ../../hardware
      ../../programs
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  custom.nixos.programs.ssh.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    emacs
    wget
    curl
  ];
}


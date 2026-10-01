{ lib, pkgs, ... }:

{
  imports =
    [
      ../../hardware
      ../../programs
      ../../suites
      ../../behavior
    ];

  time.timeZone = "America/New_York";

  users.users.lord_gabem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    linger = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  custom.nixos.programs.ssh.enable = true;

  nix.settings.trusted-users = [ "@wheel" ];

  environment.systemPackages = with pkgs; [
    emacs
    wget
    curl
    rsync
  ];
}

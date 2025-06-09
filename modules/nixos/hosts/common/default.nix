{ lib, pkgs, ... }:

{
  imports =
    [
      ../../hardware
      ../../programs
      ../../suites
      ../../themes
    ];

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

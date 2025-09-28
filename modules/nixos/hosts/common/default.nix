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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

  environment.systemPackages = with pkgs; [
    emacs
    wget
    curl
    rsync
  ];
}

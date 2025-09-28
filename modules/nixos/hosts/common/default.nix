{ pkgs, ... }:

{
  imports =
    [
      ../../hardware
      ../../programs
      ../../suites
      ../../themes
      ../../../home/opts
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  custom.nixos.programs.ssh.enable = true;

  environment.systemPackages = with pkgs; [
    emacs
    wget
    curl
    rsync
  ];
}


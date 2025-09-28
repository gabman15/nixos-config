{ pkgs, ... }:

{
  networking.hostName = "yukari"; # Define your hostname.
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # For swaylock
  security.pam.services.swaylock = { };
  security.polkit.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lord_gabem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;
  # Enable the OpenSSH daemon.
  custom.nixos.programs.ssh.enable = true;

  custom.nixos.hardware.framework-13.enable = true;

  system.stateVersion = "24.11";
}

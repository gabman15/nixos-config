{ pkgs, ... }:

{
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
    linger = true;
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "lord_gabem";
      };
    };
  };

  services.tailscale.enable = true;
  # custom.nixos.programs.gnupg.enable = true;
  custom.nixos.hardware.framework-13.enable = true;

  custom.nixos.suites.graphical.enable = true;

  system.stateVersion = "24.11";
}

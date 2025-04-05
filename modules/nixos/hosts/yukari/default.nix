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

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = ./../img.jpg;
    fonts = {
      serif = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      sansSerif = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      monospace = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      emoji = {
        package = (pkgs.nerdfonts.override { fonts =  [ "Hack" ]; });
        name = "Hack";
      };
      sizes = {
        applications = 15;
        terminal = 18;
        desktop = 15;
        popups = 15;
      };
    };
  };

  services.tailscale.enable = true;
  # custom.nixos.programs.gnupg.enable = true;
  custom.nixos.hardware.framework-13.enable = true;

  custom.nixos.suites.graphical.enable = true;

  system.stateVersion = "24.11";
}

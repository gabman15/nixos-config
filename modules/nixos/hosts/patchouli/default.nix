{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lord_gabem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  wsl = {
    enable = true;
    defaultUser = "lord_gabem";
    wslConf = {
      network.generateHosts = false;
      network.generateResolvConf = false;
      interop.appendWindowsPath = false;
    };
    
  };

  networking.nameservers = [
    "1.1.1.1"
  ];
  
  system.stateVersion = "24.11";
}

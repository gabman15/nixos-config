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
    linger = true;
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;

  custom.nixos.programs.docker.enable = true;

  virtualisation.docker.daemon.settings = {
    "default-address-pools" = [
      {
        "base" = "192.168.0.1/16";
        "size" = 24;
      }
    ];
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

  networking.nameservers = [ "1.1.1.1" ];

  # systemd.services.resolvconf-wsl = {
  #   enable = true;
  #   description = "Generate resolvconf with nameserver and search domain from windows host";
  #   wantedBy = ["network-online.target"];
  #   after = [ "mnt-c.mount" ];
  #   script = ''
  #       touch /etc/resolv.conf

  #       # Run the PowerShell command to generate "nameserver" lines and append to /etc/resolv.conf
  #       /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command '(Get-DnsClientServerAddress -AddressFamily IPv4).ServerAddresses | ForEach-Object { "nameserver $_" }' | tr -d '\r'| tee /etc/resolv.conf > /dev/null
    
  #       # Run the PowerShell command to generate "search" line and append to /etc/resolv.conf
  #       /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command '(Get-DnsClientGlobalSetting).SuffixSearchList | ForEach-Object { "search $_" }' | tr -d '\r'| tee -a /etc/resolv.conf > /dev/null
  #     '';
  # };

  system.stateVersion = "24.11";
}

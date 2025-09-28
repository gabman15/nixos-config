{ pkgs, outputs, ... }:

{
  imports = [
    ./programs/sway
  ];
  home.packages = with pkgs; [
    fastfetch
    noto-fonts
    hack-font
    librewolf
    signal-desktop
    git
    vesktop
    outputs.packages.${pkgs.system}.emacs
  ];
  
  custom.home.programs.sway.enable = true;
  
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };
  home.stateVersion = "24.11";
}

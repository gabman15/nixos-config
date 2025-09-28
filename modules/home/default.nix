{ pkgs, ... }:

{
  imports = [
    ./programs/emacs
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
  ];
  
  custom.home.programs.sway.enable = true;
  custom.home.programs.emacs.enable = true;
  
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };
  home.stateVersion = "24.11";
}

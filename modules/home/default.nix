{ inputs, pkgs, outputs, ... }:

{
  imports = [
    inputs.agenix.homeManagerModules.default
    ./programs/sway
    ./programs/backgrounder
    
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
    inputs.agenix.packages.${pkgs.system}.default
    
  ];
  
  custom.home.programs.sway.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.kitty.enable = true;
  
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };

  age.secrets.backgrounder-config.file = ../../secrets/backgrounder-config.age;

  
  home.stateVersion = "24.11";
}

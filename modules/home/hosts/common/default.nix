{ inputs, pkgs, outputs, ... }:

{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../programs
    ../../behavior
  ];
  home.packages = with pkgs; [
    fastfetch
    noto-fonts
    hack-font
    git
    outputs.packages.${pkgs.system}.emacs
    inputs.agenix.packages.${pkgs.system}.default
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };

  custom.home.behavior.xdg.enable = true;
}

{ config, inputs, pkgs, outputs, ... }:

{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../programs
    ../../behavior
    ../../opts
  ];
  home.packages = with pkgs; [
    fastfetch
    noto-fonts
    noto-fonts-cjk-sans
    hack-font
    # nerdfonts.override { fonts = [ "Hack" ]; }
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
  
  age.secrets.${config.custom.home.opts.hostname} = {
    file = ../../../../secrets/${config.custom.home.opts.hostname}.age;
  };
  custom.home.programs.bash.sprite = config.age.secrets.${config.custom.home.opts.hostname}.path;
}

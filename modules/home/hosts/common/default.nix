{ lib, config, inputs, pkgs, outputs, ... }:

{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../programs
    ../../behavior
    ../../opts
    ../../suites
  ];
  home.packages = with pkgs; [
    fastfetch
    git
    ranger
    outputs.packages.${pkgs.system}.emacs
    inputs.agenix.packages.${pkgs.system}.default
    inputs.home-manager.packages.${pkgs.system}.default
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "posy-cursors"
    ];

  custom.home.behavior.xdg.enable = true;
  custom.home.programs.bash.enable = true;
  
  age.secrets.${config.custom.home.opts.hostname} = {
    file = ../../../../secrets/${config.custom.home.opts.hostname}.age;
  };
  custom.home.programs.bash.sprite = config.age.secrets.${config.custom.home.opts.hostname}.path;
}

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
    ripgrep
    fzf
    inputs.agenix.packages.${pkgs.system}.default
    inputs.home-manager.packages.${pkgs.system}.default
  ];

  home.sessionVariables.EDITOR = "emacs";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack" ];
    };
  };
  programs.nix-index-database.comma.enable = true;
  custom.home.behavior.xdg.enable = true;
  custom.home.programs.bash.enable = true;
  custom.home.programs.emacs.enable = true;
  
  age.secrets.${config.custom.opts.hostname} = {
    file = ../../../../secrets/${config.custom.opts.hostname}.age;
  };
  custom.home.programs.bash.sprite = config.age.secrets.${config.custom.opts.hostname}.path;
}

{ lib, config, inputs, pkgs, outputs, ... }:

{
  imports = [
    ../../programs
    ../../behavior
    ../../opts
    ../../suites
  ];

  home.sessionVariables.EDITOR = "emacs";

  programs.nix-index-database.comma.enable = true;
  custom.home = {
    behavior.xdg.enable = true;
    programs = {
      bash.enable = true;
      bash.sprite = config.age.secrets.${config.custom.opts.hostname}.path;
      emacs.enable = true;
      ranger.enable = true;
      utils.enable = true;
    };
  };
  age.secrets.${config.custom.opts.hostname} = {
    file = ../../../../secrets/${config.custom.opts.hostname}.age;
  };

}

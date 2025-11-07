{ lib, config, inputs, pkgs, outputs, ... }:

{
  imports = [
    ../../programs
    ../../behavior
    ../../opts
    ../../suites
  ];
  home.packages = with pkgs; [
    fastfetch
    git
    git-crypt
    ripgrep
    fzf
    inputs.agenix.packages.${pkgs.system}.default
    inputs.home-manager.packages.${pkgs.system}.default
  ];

  home.sessionVariables.EDITOR = "emacs";

  programs.nix-index-database.comma.enable = true;
  custom.home.behavior.xdg.enable = true;
  custom.home.programs.bash.enable = true;
  custom.home.programs.emacs.enable = true;
  custom.home.programs.ranger.enable = true;
  
  age.secrets.${config.custom.opts.hostname} = {
    file = ../../../../secrets/${config.custom.opts.hostname}.age;
  };
  custom.home.programs.bash.sprite = config.age.secrets.${config.custom.opts.hostname}.path;
}

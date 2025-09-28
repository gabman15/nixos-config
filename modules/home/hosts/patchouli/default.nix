{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];

  custom.home.programs.bash.enable = true;
  
  home.stateVersion = "24.11";
}

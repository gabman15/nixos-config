{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  custom.home.programs.bash.enable = true;
  
  home.stateVersion = "24.11";
}

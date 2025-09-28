{ pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    signal-desktop
    vesktop
    pulsemixer
  ];
  
  custom.home.programs.sway.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.bash.enable = true;
  custom.home.programs.mpv.enable = true;

  age.secrets.backgrounder-config.file = ../../../../secrets/backgrounder-config.age;

  home.stateVersion = "24.11";
}

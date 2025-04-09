{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    librewolf
    signal-desktop
    vesktop
    pulsemixer
    pass
    gnupg
    cantata
    ranger
  ];


  custom.home.programs.sway.enable = true;
  custom.home.programs.waybar.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.mpv.remote = true;
  custom.home.programs.gnupg.enable = true;
  custom.home.programs.rofi.enable = true;

  custom.home.suites.mpd.enable = true;
  custom.home.suites.mpd.mpd-host = "nitori";

  # stylix.enable = true;
  
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.targets = {
    rofi.enable = true;
  };

  home.sessionVariables = lib.mkForce {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  age.secrets.backgrounder-config.file = ../../../../secrets/backgrounder-config.age;

  home.stateVersion = "24.11";
}

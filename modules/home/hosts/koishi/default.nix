{ inputs, config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    antimicrox
    cantata
    ymuse
    ludusavi
    vesktop
    librewolf
    signal-desktop
    pass
    gamemode
    gamescope
    r2modman
    prismlauncher
    ffmpeg
    yt-dlp
    mullvad-browser
    wineWowPackages.staging
    winetricks
    picard
    p7zip
    imv
    (inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable.override {
       location = "/games/pc/osu/prefix";
    })
  ];

  custom.home.suites.graphical.enable = true;
  custom.home.suites.mpd.enable = true;
  custom.home.suites.dev.enable = true;

  custom.home.programs.rofi.enable = true;
  custom.home.programs.backgrounder.enable = true;
  custom.home.programs.sway.enable = true;
  custom.home.programs.waybar.enable = true;
  custom.home.programs.mpv.enable = true;
  custom.home.programs.gnupg.enable = true;
  custom.home.programs.kitty.enable = true;
  custom.home.programs.mpd.enable = true;
  custom.home.programs.discord.enable = true;
  custom.home.programs.mavica-ingest.enable = true;
  custom.home.programs.gallery-dl.enable = true;

  custom.themes.enable = true;
  custom.home.opts.stylix = true;
  custom.home.opts.screens = {
    "Acer Technologies XV272U 0x1121BA45" = {
      output = {
        position = "0 0";
        resolution = "2560x1440@143.999Hz";
      };
      workspace = "1";
    };
    "BNQ BenQ RL2455 92F07277SL0" = {
      output = {
        position = "2560 0";
        resolution = "1920x1080@60.000Hz";
        transform = "270";
      };
      workspace = "5";
    };
  };
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";


  home.stateVersion = "25.05";
}

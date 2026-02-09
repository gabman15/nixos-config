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
    mullvad-browser
    wineWowPackages.staging
    winetricks
    picard
    imv
    waypipe
    np2kai
    dosbox-x
    libreoffice
    (inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable.override {
       location = "/games/pc/osu/prefix";
    })
  ];

  custom = {
    themes.enable = true;
    home = {
      suites = {
        fonts.enable = true;
        mpd.enable = true;
        dev.enable = true;
      };
      programs = {
        tmux.enable = true;
        rofi.enable = true;
        backgrounder.enable = true;
        sway.enable = true;
        waybar.enable = true;
        mpv.enable = true;
        gnupg.enable = true;
        kitty.enable = true;
        mpd.enable = true;
        discord.enable = true;
        mavica-ingest.enable = true;
        gallery-dl.enable = true;
      };
      opts.stylix = true;
      opts.screens = {
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
    };
  };
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";


  home.stateVersion = "25.05";
}

pkgs:

{
  enable = true;
  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  image = ./../img.jpg;
  fonts = {
    serif = {
      package = pkgs.hack-font;
      name = "Hack";
    };

    sansSerif = {
      package = pkgs.hack-font;
      name = "Hack";
    };

    monospace = {
      package = pkgs.hack-font;
      name = "Hack";
    };

    emoji = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack";
    };
    sizes = {
      applications = 12;
      terminal = 13;
      desktop = 12;
      popups = 12;
    };
  };
  targets.qt = {
    enable = true;
    platform = "qtct";
  };
  cursor = {
    name = "Posy_Cursor_Black_125_175";
    package = pkgs.posy-cursors;
    size = 40;
  };
}

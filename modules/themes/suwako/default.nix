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
      package = (pkgs.nerdfonts.override { fonts =  [ "Hack" ]; });
      name = "Hack";
    };
    sizes = {
      applications = 15;
      terminal = 18;
      desktop = 15;
      popups = 15;
    };
  };
}

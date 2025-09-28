pkgs:

{
  fonts.sizes = {
    applications = 12;
    terminal = 13;
    desktop = 12;
    popups = 12;
  };
  cursor.size = 40;
  iconTheme = {
    enable = true;
    package = pkgs.gruvbox-dark-icons-gtk;
    light = "oomox-gruvbox-dark";
    dark = "oomox-gruvbox-dark";
  };
}

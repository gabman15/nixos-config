config:

{
  stylix.targets.sway.enable = false;
  wayland.windowManager.sway = {
    config = with config.lib.stylix.colors.withHashtag; let
      text = base05;
      urgent = base08;
      focused = base0C;
      unfocused = base03;

      fonts = {
        names = [ config.stylix.fonts.sansSerif.name ];
        size = config.stylix.fonts.sizes.desktop + 0.0;
      };
      background = base00;
      indicator = base0B;
    in {
      inherit fonts;
      colors = {
        inherit background;
        urgent = {
          inherit background indicator text;
          border = urgent;
          childBorder = urgent;
        };
        focused = {
          inherit background indicator text;
          border = focused;
          childBorder = focused;
        };
        focusedInactive = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
        unfocused = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
        placeholder = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
      };
    };
  };
}

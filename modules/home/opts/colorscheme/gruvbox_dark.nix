let
  foreground = "#EBDBB2";
  background = "#282828";

  color0 = "#282828";
  color8 = "#928374";

  #:black

  color1 = "#cc241d";
  color9 = "#fb4934";

  #:red

  color2 = "#98971a";
  color10 = "#b8bb26";

  #:green

  color3 = "#d79921";
  color11 = "#fabd2f";

  #:yellow

  color4 = "#458588";
  color12 = "#83a598";

  #:blue

  color5 = "#b16286";
  color13 = "#d3869b";

  #:magenta

  color6 = "#689d6a";
  color14 = "#8ec07c";

  #:cyan

  color7 = "#a89984";
  color15 = "#ebdbb2";
  #   red-d5 = "#190000";
  # red-d4 = "#330000";
  # red-d3 = "#4C0000";
  # red-d2 = "#990000";
  # red-d1 = "#CC0000";
  # red    = "#FF0000";
  # red-b1 = "#FF3333";
  # red-b2 = "#FF6666";
  # red-b3 = "#FF9999";

  # red-ds1-d2 = "#993333";
  # red-ds2 = "#FF5555";

  # gray = "#555555";


in {
  terminal = rec {
    inherit
      foreground
      background
      color0
      color1
      color2
      color3
      color4
      color5
      color6
      color7
      color8
      color9
      color10
      color11
      color12
      color13
      color14
      color15;

    cursor = foreground;
    selection-foreground = background;
    selection-background = foreground;

    # color0  = background;
    # color1  = color1;
    # color2  = color2;
    # color3  = color3;
    # color4  = color4;
    # color5  = red-b2;
    # color6  = red-b3;
    # color7  = foreground;
    # color8  = gray;
    # color9  = red-d2;
    # color10 = red-d1;
    # color11 = red;
    # color12 = red-b1;
    # color13 = red-b2;
    # color14 = red-b3;
    # color15 = foreground;
  };

  wm = rec {
    inherit background;
    text = foreground;

    # foreground-dim = red-d4;
    # foreground-normal = red-d1;
    # foreground-alert = red-ds2;

    foreground-alt-normal = foreground;

    # bg-select-dim = red-d5;
    # bg-select-normal = red-d4;
    # bg-select-bright = red-d3;
    # bg-select-alert = red-ds1-d2;

    # bg-select-alt-normal = gray;
  };
}

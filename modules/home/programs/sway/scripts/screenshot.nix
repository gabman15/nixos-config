pkgs: config:

pkgs.writeShellScript "sway-screenshot" ''
  home=/home/${config.home.username}
  scrdir=$home/pictures/screenshots/grim

  ${pkgs.wayfreeze}/bin/wayfreeze --hide-cursor & PID=$!
  ${pkgs.coreutils}/bin/sleep 0.02
  area="$(${pkgs.slurp}/bin/slurp -o -w 0)"

  outputfile="$(${pkgs.coreutils}/bin/date +$scrdir/%s.png)"

  ${pkgs.grim}/bin/grim -g "$area" - | \
      tee $outputfile | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
          # >(${pkgs.wl-clipboard}/bin/wl-copy -t image/png) \
          #  \
          # > /dev/null

  ${pkgs.util-linux}/bin/kill $PID
''

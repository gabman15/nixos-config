pkgs: config:

pkgs.writeShellScript "sway-screenshot" ''
  translation=false

  while getopts ":t" opt; do
    case $opt in
      t)
        translation=true
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
  done
  home=/home/${config.home.username}
  scrdir=$XDG_PICTURES_DIR/screenshots/grim

  ${pkgs.wayfreeze}/bin/wayfreeze --hide-cursor & PID=$!
  ${pkgs.coreutils}/bin/sleep 0.02
  area="$(${pkgs.slurp}/bin/slurp -o -w 0)"
  if [ $translation = true ]; then
    mkdir -p /tmp/translation
    outputfile="/tmp/translation/img.png"
  else
    mkdir -p $srcdir
    outputfile="$(${pkgs.coreutils}/bin/date +$scrdir/%s.png)"
  fi

  ${pkgs.grim}/bin/grim -g "$area" - | \
      tee $outputfile | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
          # >(${pkgs.wl-clipboard}/bin/wl-copy -t image/png) \
          #  \
          # > /dev/null

  ${pkgs.util-linux}/bin/kill $PID
''

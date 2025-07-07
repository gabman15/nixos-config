pkgs: config:

pkgs.writeShellScript "translate" ''
  if [[ -z $WAYLAND_DISPLAY ]]; then
    exit 1
  fi
  TL="$(${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.translate-shell}/bin/trans -b ja:en)"
  ACTION=$(${pkgs.dunst}/bin/dunstify --action="default,copy" Translation "$TL")
  case "$ACTION" in
    "default")
      echo "$TL" | ${pkgs.wl-clipboard}/bin/wl-copy
      ;;
  esac
''

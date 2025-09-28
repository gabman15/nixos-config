pkgs: config: screenshot: translate:

pkgs.writeShellScript "translate-sway-screenshot" ''
  running=$(ps aux | grep manga_ocr | grep -v grep)
  if [ -z "$running" ]; then
     ${pkgs.python312Packages.manga-ocr}/bin/manga_ocr "/tmp/translation" & PID=$!
  fi
  ${screenshot} -t
  clip=$(${pkgs.wl-clipboard}/bin/wl-paste -l)
  while [[ $clip != "text/plain"* ]]; do
    sleep 1
    clip=$(${pkgs.wl-clipboard}/bin/wl-paste -l)
  done
  if [ -z "$running" ]; then
    ${pkgs.util-linux}/bin/kill $PID
  fi
  ${pkgs.dunst}/bin/dunstify manga-ocr "$(${pkgs.wl-clipboard}/bin/wl-paste)"
  ${translate}
''

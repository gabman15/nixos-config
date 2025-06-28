pkgs: config:

pkgs.writeShellScript "mpd-button" ''
  MPC_STATUS="$(mpc status %state%)"
  if [ "$MPC_STATUS" == 'paused' ]; then
    FORMAT=""
  else
    FORMAT=""
  fi
  echo $FORMAT
''

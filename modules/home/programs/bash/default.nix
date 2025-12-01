{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.bash;
in
  {
    options.custom.home.programs.bash = {
      enable = mkEnableOption "bash shell";
      sprite = mkOption {
        description = "Touhou sprite";
        type = with types; nullOr str;
        default = null;
      };
      zfs = mkEnableOption "output zfs status";
    };


    config = mkIf cfg.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "ls -lha --color=auto";
          rb = "sudo nixos-rebuild switch";
          hrb = "home-manager switch --flake .#${config.custom.opts.hostname}";
        };

        initExtra = let
          spriteCat = if cfg.sprite == null then "" else ''
            ${pkgs.coreutils}/bin/cat ${cfg.sprite}
          '';
          # Thanks jbwar22 for the zfs status code! https://github.com/jbwar22
          zfsStatus = if !cfg.zfs then "" else ''
            ZPOOL_STATUS_SCAN_3L="$(zpool status | grep -A 2 scan:)"
            IFS=$'\n' ZPOOL_STATUS_SCAN_LINES=($ZPOOL_STATUS_SCAN_3L)

            ZPOOL_STATUS_SCAN="$(echo "''${ZPOOL_STATUS_SCAN_LINES[0]}")"
            ZPOOL_STATUS_X="$(zpool status -x)"

            ZPOOL_STATUS_SCAN_REGEX="scrub (repaired [^\\s]+) (in [^\\s]+) (with [^\\s]+ errors) (on .*)"
            ZPOOL_STATUS_SCAN_REGEX_INP="scrub in progress (since .*)"

            if [ "$ZPOOL_STATUS_X" == "all pools are healthy" ] && [[ $ZPOOL_STATUS_SCAN =~ $ZPOOL_STATUS_SCAN_REGEX ]]; then
                printf "\n\n''${BASH_REMATCH[4]}\n''${BASH_REMATCH[1]} ''${BASH_REMATCH[3]}\n\n''${ZPOOL_STATUS_X}"
            elif [ "$ZPOOL_STATUS_X" == "all pools are healthy" ] && [[ $ZPOOL_STATUS_SCAN =~ $ZPOOL_STATUS_SCAN_REGEX_INP ]]; then
                printf "\n\nscrub in progress\n''${BASH_REMATCH[1]}\n\n''${ZPOOL_STATUS_X}"
            else
                zpool status -v
            fi
          '';
          footer = ''
            QUOTE="$(${inputs.gensoquote.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/gensoquote -f '\"%q\"\n-- %c, \"%s\"' | fold -w $(($COLUMNS-6)))"
            EXTRA_INFO="$(${zfsStatus})"
            printf "''${QUOTE}''${EXTRA_INFO}\n" | ${pkgs.boxes}/bin/boxes -d stone
          '';
        in
          ''
          PS1='[\[\033[1;36m\]\u@\h \[\033[33m\]\W\[\033[00m\]]\$ '
          export PATH="$HOME/.local/bin:$PATH"
          ${spriteCat}
          ${footer}
          export PF_COL1=6
          export PF_COL3=3
          export PF_INFO="title os host kernel uptime pkgs memory"
          ${pkgs.pfetch}/bin/pfetch
          '';
      };
    };
  }

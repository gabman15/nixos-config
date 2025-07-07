{ lib, ... }:

with lib; {
  options.custom.home.opts.screens = mkOption {
    type = with types; nullOr (attrsOf (submodule {
      options = {
        sway = mkOption {
          type = with types; attrsOf str;
          description = "sway outputs";
        };
      };
    }));
  };
}

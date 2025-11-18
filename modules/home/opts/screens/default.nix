{ lib, ... }:

with lib; {
  options.custom.home.opts.screens = mkOption {
    type = with types; nullOr (attrsOf (submodule {
      options = {
        output = mkOption {
          type = with types; attrsOf str;
          description = "sway outputs";
        };
        workspace = mkOption {
          type = types.str;
          description = "sway output workspace";
        };
      };
    }));
  };
}

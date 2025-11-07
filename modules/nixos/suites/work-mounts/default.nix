{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.work-mounts;
in
  {
    options.custom.nixos.suites.work-mounts = {
      enable = mkEnableOption "network mount configurations for work";
    };
    
    config = let
      work-path-loc = ../../../../secrets/git-crypt;
      work-mount-list = builtins.genList (x: toString (x + 1)) 5;
    in mkIf cfg.enable {
      age.secrets = {
        smb-work-paths = {
          file = ../../../../secrets/smb-work-paths.age;
        };
        smb-work-creds = {
          file = ../../../../secrets/smb-work-creds.age;
        };
      };
      systemd.mounts = map (x: {
        description = "work mount ${x}";
        what = "\${WORK_MOUNT${x}_WHAT}";
        type = "cifs";
        where = trim (readFile (lib.path.append work-path-loc "work${x}-path"));
        options = "credentials=${config.age.secrets.smb-work-creds.path}";
        mountConfig = {
          EnvironmentFile = config.age.secrets.smb-work-paths.path;
        };
      }) work-mount-list;

      systemd.automounts = map (x: {
        description = "Automount for work mount ${x}";
          where = trim (readFile (lib.path.append work-path-loc "work${x}-path"));
          wantedBy = [ "multi-user.target" ];
          automountConfig = {
            EnvironmentFile = config.age.secrets.smb-work-paths.path;
          };
      }) work-mount-list;
    };
  }

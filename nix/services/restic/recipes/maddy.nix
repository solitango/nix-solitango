{
  config,
  lib,
  ...
}: let
  cfg = config.solitango.services.restic;
  maddyCfg = config.solitango.services.maddy;

  enabled = cfg.enable && maddyCfg.enable;
in
  lib.mkIf enabled {
    services.restic.backups.maddy = {
      inherit (maddyCfg) user;
      inherit (cfg) repositoryFile passwordFile environmentFile;

      initialize = true;
      timerConfig.OnCalendar = "04:00";

      paths = [
        "/var/lib/maddy"
      ];
    };
  }

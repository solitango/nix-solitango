{config, ...}: let
  cfg = config.solitango.storage;

  excludingPaths = [
    "/etc/machine-id"
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
  ];
in {
  services.restic.backups.data = {
    inherit (cfg.restic) repositoryFile passwordFile environmentFile;

    initialize = true;
    timerConfig.OnCalendar = "04:00";

    paths = builtins.filter (path: !builtins.elem path excludingPaths) (
      cfg.persistent.files ++ cfg.persistent.directories
    );
  };
}

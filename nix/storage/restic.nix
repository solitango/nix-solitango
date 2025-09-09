{config, ...}: let
  cfg = config.solitango.storage;

  excludingPaths = [
    "/etc/machine-id"
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
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

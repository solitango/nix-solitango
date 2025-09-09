{config, ...}: let
  cfg = config.solitango.storage;
in {
  environment.persistence."${cfg.persistent.mountpoint}" = {
    inherit (cfg.persistent) files directories;
  };
}

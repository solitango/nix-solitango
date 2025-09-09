{config, ...}: let
  cfg = config.solitango.storage;
in {
  services.snapper.configs.persistent = {
    SUBVOLUME = cfg.persistent.mountpoint;

    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = 24;
    TIMELINE_LIMIT_DAILY = 7;
    TIMELINE_LIMIT_WEEKLY = 0;
    TIMELINE_LIMIT_MONTHLY = 0;
    TIMELINE_LIMIT_YEARLY = 0;
  };
}

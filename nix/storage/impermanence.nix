{config, ...}: let
  cfg = config.solitango.storage;
in {
  environment.persistence."${cfg.persistentStorageMountpoint}" = {
    files = cfg.persistentFiles;
    directories = cfg.persistentDirectories;
  };
}

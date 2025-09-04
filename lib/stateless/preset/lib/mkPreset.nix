{
  checkOptionAccessor ? _: true,
  persistentDirectories ? [],
  persistentFiles ? [],
}: {
  config,
  lib,
  ...
}: let
  enabled = config.solitango.stateless.enable && checkOptionAccessor config;
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in
  lib.mkIf enabled {
    environment.persistence."${persistentStorageMountpoint}".directories = persistentDirectories;
    environment.persistence."${persistentStorageMountpoint}".files = persistentFiles;
  }

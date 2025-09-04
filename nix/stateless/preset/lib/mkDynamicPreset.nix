{
  checkOptionAccessor ? _: true,
  persistentDirectoriesAccessor ? _: [],
  persistentFilesAccessor ? _: [],
}: inputs @ {
  config,
  lib,
  ...
}: let
  enabled = config.solitango.stateless.enable && checkOptionAccessor config;
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in
  lib.mkIf enabled {
    environment.persistence."${persistentStorageMountpoint}" = {
      directories = persistentDirectoriesAccessor inputs;
      files = persistentFilesAccessor inputs;
    };
  }

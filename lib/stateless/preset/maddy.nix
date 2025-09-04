{
  config,
  lib,
  ...
}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in {
  environment.persistence."${persistentStorageMountpoint}".directories = lib.mkIf config.services.maddy.enable [
    "/var/lib/maddy"
  ];
}

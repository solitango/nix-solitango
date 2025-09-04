{
  config,
  lib,
  ...
}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in {
  environment.persistence."${persistentStorageMountpoint}".directories = lib.mkIf config.security.acme.acceptTerms [
    "/var/lib/acme"
  ];
}

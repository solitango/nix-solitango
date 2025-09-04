{
  config,
  lib,
  ...
}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in {
  environment.persistence."${persistentStorageMountpoint}".directories = lib.mkIf config.services.fail2ban.enable [
    "/var/lib/fail2ban"
  ];
}

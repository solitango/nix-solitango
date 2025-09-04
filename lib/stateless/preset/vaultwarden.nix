{
  config,
  lib,
  ...
}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;

  name =
    if lib.versionOlder config.system.stateVersion "24.11"
    then "bitwarden_rs"
    else "vaultwarden";
in {
  environment.persistence."${persistentStorageMountpoint}".directories = lib.mkIf config.services.vaultwarden.enable [
    "/var/lib/${name}"
  ];
}

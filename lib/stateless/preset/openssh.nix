{
  config,
  lib,
  ...
}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in {
  environment.persistence."${persistentStorageMountpoint}".files = lib.mkIf config.services.openssh.enable (builtins.map (key: key.path) config.services.openssh.hostKeys);
}

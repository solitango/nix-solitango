# see https://github.com/nix-community/impermanence/issues/254
{
  config,
  lib,
  ...
}: let
  enabled = config.solitango.stateless.enable;
  persistentStorageMountpoint = config.solitango.persistentStorageMountpoint;
in
  lib.mkIf enabled {
    system.activationScripts."createPersistentStorageDirs".deps = ["var-lib-private-permissions" "users" "groups"];
    system.activationScripts = {
      "var-lib-private-permissions" = {
        deps = ["specialfs"];
        text = ''
          mkdir -p ${persistentStorageMountpoint}/var/lib/private
          chmod 0700 ${persistentStorageMountpoint}/var/lib/private
        '';
      };
    };
  }

# see https://github.com/nix-community/impermanence/issues/254
{config, ...}: let
  cfg = config.solitango.storage;
in {
  system.activationScripts = {
    "fixPersistentStorageDirPermission" = {
      deps = ["createPersistentStorageDirs"];
      text = ''
        if [ -d "${cfg.persistent.mountpoint}/var/lib/private" ]; then
          chmod 0700 "${cfg.persistent.mountpoint}/var/lib/private"
        fi
      '';
    };
  };
}

(import ./lib/mkDynamicPreset.nix) {
  checkOptionAccessor = config: config.services.openssh.enable;
  persistentDirectoriesAccessor = {
    config,
    lib,
    ...
  }: let
    name =
      if lib.versionOlder config.system.stateVersion "24.11"
      then "bitwarden_rs"
      else "vaultwarden";
  in ["/var/lib/${name}"];
}

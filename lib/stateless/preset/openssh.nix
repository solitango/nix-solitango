(import ./lib/mkDynamicPreset.nix) {
  checkOptionAccessor = config: config.services.openssh.enable;
  persistentFilesAccessor = {config, ...}: (builtins.map (key: key.path) config.services.openssh.hostKeys);
}

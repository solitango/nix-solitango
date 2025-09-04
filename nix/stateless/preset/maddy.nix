(import ./lib/mkPreset.nix) {
  checkOptionAccessor = config: config.services.maddy.enable;
  persistentDirectories = ["/var/lib/maddy"];
}

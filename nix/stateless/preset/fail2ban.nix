(import ./lib/mkPreset.nix) {
  checkOptionAccessor = config: config.services.fail2ban.enable;
  persistentDirectories = ["/var/lib/fail2ban"];
}

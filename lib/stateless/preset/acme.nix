(import ./lib/mkPreset.nix) {
  checkOptionAccessor = config: config.security.acme.acceptTerms;
  persistentDirectories = ["/var/lib/acme"];
}

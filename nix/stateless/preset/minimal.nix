(import ./lib/mkPreset.nix) {
  persistentDirectories = [
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
  ];

  persistentFiles = [
    "/etc/machine-id"
  ];
}

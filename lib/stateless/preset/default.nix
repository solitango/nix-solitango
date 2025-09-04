{config, ...}: let
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in {
  imports = [
    ./acme.nix
    ./fail2ban.nix
    ./maddy.nix
    ./openssh.nix
    ./vaultwarden.nix
  ];

  environment.persistence."${persistentStorageMountpoint}" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}

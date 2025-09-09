{lib, ...}: {
  options.solitango.storage = {
    mainDisk = lib.mkOption {
      type = lib.types.str;
      example = "/dev/sda";
    };

    persistent = {
      mountpoint = lib.mkOption {
        type = lib.types.str;
        default = "/persistent";
      };

      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };

      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };

    restic = {
      passwordFile = lib.mkOption {
        type = lib.types.string;
      };

      repositoryFile = lib.mkOption {
        type = lib.types.string;
      };

      environmentFile = lib.mkOption {
        type = lib.types.string;
      };
    };
  };

  solitango.storage.persistent = {
    files = [
      "/etc/machine-id"
    ];

    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
  };

  imports = [
    ./disk.nix
    ./fixPermission.nix
    ./impermanence.nix
    ./restic.nix
    ./snapper.nix
  ];
}

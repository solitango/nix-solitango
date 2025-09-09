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
        default = [
          "/etc/machine-id"
        ];
      };

      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
        ];
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

  imports = [
    ./disk.nix
    ./fixPermission.nix
    ./impermanence.nix
    ./restic.nix
    ./snapper.nix
  ];
}

{lib, ...}: {
  options.solitango.storage = {
    mainDisk = lib.mkOption {
      type = lib.types.string;
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
  };

  imports = [
    ./disk.nix
    ./fixPermission.nix
    ./impermanence.nix
    ./snapper.nix
  ];
}

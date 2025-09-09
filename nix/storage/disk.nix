{config, ...}: let
  cfg = config.solitango.storage;
in {
  disko.devices = {
    disk = {
      main = {
        device = cfg.mainDisk;
        type = "disk";
        content = {
          type = "gpt";

          partitions = {
            MBR = {
              priority = 0;

              type = "EF02";
              size = "1M";
            };

            ESP = {
              priority = 1;

              type = "EF00";
              size = "200M";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                  "nosuid"
                  "noexec"
                  "nodev"
                ];
              };
            };

            root = {
              size = "100%";

              content = {
                type = "btrfs";
                extraArgs = ["-f"];

                subvolumes = {
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                      "nosuid"
                    ];
                  };

                  "@persistent" = {
                    mountpoint = "${cfg.persistentStorageMountpoint}";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "nosuid"
        "noexec"
        "mode=755"
      ];
    };
  };

  fileSystems."/nix".neededForBoot = true;
  fileSystems."${cfg.persistentStorageMountpoint}".neededForBoot = true;

  virtualisation.vmVariantWithDisko.virtualisation.fileSystems."/nix".neededForBoot = true;
  virtualisation.vmVariantWithDisko.virtualisation.fileSystems."${
    cfg.persistentStorageMountpoint
  }".neededForBoot =
    true;
}

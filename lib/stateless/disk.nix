{
  config,
  lib,
  ...
}: let
  enabled = config.solitango.stateless.enable;
  persistentStorageMountpoint = config.solitango.stateless.persistentStorageMountpoint;
in
  lib.mkIf enabled {
    disko.devices = {
      disk = {
        main = {
          device = "/dev/sda";
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
                  mountOptions = ["umask=0077"];
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
                      ];
                    };

                    "@persistent" = {
                      mountpoint = "${persistentStorageMountpoint}";
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
    fileSystems."${persistentStorageMountpoint}".neededForBoot = true;

    virtualisation.vmVariantWithDisko.virtualisation.fileSystems."/nix".neededForBoot = true;
    virtualisation.vmVariantWithDisko.virtualisation.fileSystems."${persistentStorageMountpoint}".neededForBoot = true;
  }

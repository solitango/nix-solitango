{
  config,
  lib,
  ...
}: {
  options.solitango.stateless = {
    enable = lib.mkEnableOption "Whether to make this machine stateless.";

    persistentStorageMountpoint = lib.mkOption {
      type = lib.types.string;
      default = "/persistent";
      description = "The mountpoint for the persistent storage.";
    };
  };

  config = lib.mkIf config.solitango.stateless.enable {
    imports = [
      ./preset

      ./disk.nix
      ./fixPermission.nix
    ];
  };
}

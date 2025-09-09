{lib, ...}: {
  options.solitango.services.restic = {
    enable = lib.mkEnableOption "Restic";

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

  imports = [
    ./recipes
  ];
}

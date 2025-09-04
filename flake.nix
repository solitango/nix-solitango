{
  inputs = {
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    disko,
    impermanence,
    ...
  }: {
    nixosModules = rec {
      default = solitango;
      solitango = {
        imports = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence

          ./nix
        ];
      };
    };
  };
}

{ inputs, ... }:
{
  flake.modules.nixos.homeManagerFeature = {
    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "nixbak";
    };
  };
}

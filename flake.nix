# vim: et sw=2
{
  description = "Firegem's NixOS system flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      nixosConfigurations = {
        delphi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # Pass flake inputs to modules.
          specialArgs = { inherit inputs; };

          modules = [
            # Default host entry points.
            ./hosts/delphi/configuration.nix
            ./hosts/delphi/hardware-configuration.nix

            # Setup the home-manager module for this host.
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cheer = import ./users/cheer/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                constants = {
                  git = {
                    name = "Firegem";
                    email = "5158194+Mrfiregem@users.noreply.github.com";
                  };
                };
              };
              home-manager.sharedModules = [
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
              ];
              home-manager.backupFileExtension = "nixbak";
            }
          ];
        };
      };
    };
}

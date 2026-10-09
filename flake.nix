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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      myLib = import ./lib { inherit (nixpkgs) lib; inherit pkgs; };
    in
    {
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
              home-manager.extraSpecialArgs = { inherit inputs myLib; };
            }
          ];
        };
      };
    };
}

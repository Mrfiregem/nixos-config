{ inputs, ... }:
{
  flake.modules.homeManager.flatpakModule = {
    imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

    services.flatpak = {
      enable = true;
    };
  };
}

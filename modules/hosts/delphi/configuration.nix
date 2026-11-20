{ inputs, self, ... }:
{
  flake.nixosConfigurations.delphi = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.modules.nixos; [
      ./_hardware-configuration.nix
      delphiModule
      grubBootloader
      gnomeDE

      allowUnfreeFeature
      homeManagerFeature
      nixCommandFeature

      fontCoverage
      i18nModule
      networkManager
      pipewireAudio
      printing
      steam
    ];
  };

  flake.modules.nixos.delphiModule = { pkgs, ... }: {
    system.stateVersion = "26.05";

    networking.hostName = "delphi";
    time.timeZone = "America/New_York";

    users.users."cheer" = {
      isNormalUser = true;
      description = "Cheer";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
    programs.fish.enable = true;

    home-manager.users."cheer" = self.modules.homeManager.delphiUser;
  };
}

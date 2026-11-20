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
      ghostty
      i18nModule
      networkManager
      nixTools
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

    # Since we use nix-flatpak, flatpak needs to be installed here.
    services.flatpak.enable = true;

    home-manager.users."cheer" = self.modules.homeManager.delphiUser;
  };
}

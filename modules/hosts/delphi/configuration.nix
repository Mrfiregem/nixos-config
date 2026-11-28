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
    # Version set during first install.
    system.stateVersion = "26.05";

    # Set system hostname and timezone.
    networking.hostName = "delphi";
    time.timeZone = "America/New_York";

    # Define user(s) for system.
    users.users."cheer" = {
      isNormalUser = true;
      description = "Cheer";
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
    programs.fish.enable = true; # For user shell.

    # Add our custom packages as a nixpkgs overlay.
    nixpkgs.overlays = [ self.overlays.default ];

    # Since we use nix-flatpak, flatpak needs to be installed here.
    services.flatpak.enable = true;

    # Use home-manager to manage userspace options.
    home-manager.users."cheer" = self.modules.homeManager.delphiUser;
  };
}

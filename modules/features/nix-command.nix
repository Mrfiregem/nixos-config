{
  flake.modules.nixos.nixCommandFeature = {
    # Enable the use of Nix flakes.
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}

{
  flake.modules.nixos.allowUnfreeFeature = {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}

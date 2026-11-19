{
  flake.modules.nixos.networkManager = {
    # Enable networking.
    networking.networkmanager.enable = true;
  };
}

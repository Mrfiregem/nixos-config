# Configure the top-level mkFlake for all other modules.
{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
}

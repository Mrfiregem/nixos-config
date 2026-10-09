{ lib, pkgs, ... }:
{
  nushell = import ./nushell.nix { inherit lib pkgs; };
}

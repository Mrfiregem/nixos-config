{ lib, ... }:
let
  mkPackages =
    callPackage:
    lib.packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ../packages;
    };
in
{
  # Make packages accessable through `nix build .#foo`
  perSystem = { pkgs, ... }: {
    packages = mkPackages pkgs.callPackage;
  };

  # Make packages accessable through pkgs.foo when overlay is defined.
  # E.g. `nixpkgs.overlays = [ inputs.self.overlays.default ]`
  flake.overlays.default = final: _prev: mkPackages final.callPackage;
}

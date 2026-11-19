{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      source = self + /bin/md5rename.nu;
    in
    {
      packages.md5rename = pkgs.writers.writeNuBin "md5rename" (builtins.readFile source);
    };
}

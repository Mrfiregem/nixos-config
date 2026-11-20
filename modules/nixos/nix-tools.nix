{
  flake.modules.nixos.nixTools = { lib, ... }: {
    # Automatically load Nix devshells.
    programs.direnv.enable = true;

    # Tool to search packages and options,
    # and also automatically GC the Nix store.
    programs.nh = {
      enable = true;
      flake = lib.mkDefault "/home/cheer/nixos-config";
      clean = {
        enable = true;
        dates = "weekly";
        # Keep 5 NixOS revisions and one direnv root per project.
        extraArgs = "--keep 5 --keep-one";
      };
    };
  };
}

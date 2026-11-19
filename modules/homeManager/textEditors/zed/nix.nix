{
  flake.modules.homeManager.zed-nixLanguage = { pkgs, ... }: {
    programs.zed-editor = {
      extensions = [ "nix" ];

      extraPackages = [
        pkgs.nixd
        pkgs.nixfmt
      ];

      userSettings = {
        languages = {
          Nix = {
            # The Nix extension enables both by default, but
            # we don't have nil installed so we disable it here.
            language_servers = [
              "nixd"
              "!nil"
              "..."
            ];
          };
        };
      };
    };
  };
}

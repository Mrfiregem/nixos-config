{
  flake.modules.homeManager.zedEditor = { pkgs, ... }: {
    programs.zed-editor = {
      extensions = [ "tsgo" ];

      extraPackages = [ pkgs.typescript ];

      userSettings =
        let
          typescript_servers = [
            "typescript-ls"
            "!vtsls"
            "..."
          ];
        in
        {
          languages = {
            TypeScript = {
              language_servers = typescript_servers;
            };
            TSX = {
              language_servers = typescript_servers;
            };
            JavaScript = {
              language_servers = typescript_servers;
            };
          };
        };
    };
  };
}

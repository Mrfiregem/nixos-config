{ self, ... }:
{
  flake.modules.homeManager.zedEditor =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      imports = with self.modules.homeManager; [
        zed-colorscheme
        zed-nixLanguage
        zed-typescriptLanguage
      ];

      # GUI code editor
      programs.zed-editor = {
        enable = true;
        package = pkgs.zed-editor-fhs;

        extensions = [
          "editorconfig"
          "emmet"
          "typos"
        ]
        ++ lib.lists.optional config.programs.nushell.enable "nu";

        userSettings = {
          disable_ai = true;
          format_on_save = "on";
        };
      };
    };
}

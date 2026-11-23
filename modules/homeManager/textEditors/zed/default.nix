{
  flake.modules.homeManager.zedEditor =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
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

        extraPackages = with pkgs; [
          emmet-language-server
          typos-lsp
        ];

        mutableUserSettings = false;
        userSettings = {
          disable_ai = true;
          format_on_save = "on";
        };
      };
    };
}

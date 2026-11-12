{
  lib,
  pkgs,
  config,
  ...
}:

{
  # GUI code editor
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;

    extensions = [
      # Styling
      "catppuccin"
      "material-icon-theme"

      # Languages
      "emmet"
      "nix"

      # Other
      "typos"
    ]
    ++ lib.lists.optional config.programs.nushell.enable "nu";

    # Install extra programs required by extensions above.
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    userSettings = {
      disable_ai = true;
      theme = {
        mode = "system";
        dark = "Catppuccin Macchiato";
        light = "Catppuccin Latte";
      };
      icon_theme = {
        mode = "system";
        dark = "Material Icon Theme";
        light = "Material Icon Theme";
      };
      format_on_save = "on";
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
}

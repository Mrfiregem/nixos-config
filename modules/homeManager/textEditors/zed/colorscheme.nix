{
  flake.modules.homeManager.zedEditor = {
    programs.zed-editor = {
      extensions = [
        "catppuccin"
        "material-icon-theme"
      ];

      userSettings = {
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
      };
    };
  };
}

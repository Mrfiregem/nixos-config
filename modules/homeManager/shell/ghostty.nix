{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "Catppuccin Macchiato";
        window-width = 100;
        window-height = 30;
      };
    };
  };
}

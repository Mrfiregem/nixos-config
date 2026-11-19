{
  flake.modules.homeManager.plasmaCursorTheme = { pkgs, ... }: {
    # Use KDE Plasma cursor theme
    home.pointerCursor = {
      enable = true;
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}

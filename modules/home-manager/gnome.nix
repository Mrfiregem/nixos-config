{ pkgs, ... }: {
  imports = [ ./custom/gnome.nix ];

  home.de.gnome = {
    enable = true;

    usePointerCursor = true;
    automaticLocation = true;
    clockFormat = "12h";

    wallpaper = {
      enable = true;
      light = ../../assets/imgs/bg-light;
      dark = ../../assets/imgs/bg-dark;
    };

    extensions = with pkgs.gnomeExtensions; [
      appindicator          # Show app icons in top bar
      in-picture            # Keep PiP windows on top
      night-theme-switcher  # Switch theme based on time
    ];
  };
}

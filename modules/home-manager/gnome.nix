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
      appindicator
      night-theme-switcher
    ];
  };
}

{ pkgs, ... }: {
  imports = [ ./custom/gnome.nix ];

  home.de.gnome = {
    enable = true;
    usePointerCursor = true;

    clockFormat = "12h";

    extensions = with pkgs.gnomeExtensions; [
      appindicator
      night-theme-switcher
    ];
  };
}

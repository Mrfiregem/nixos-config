{ pkgs, ... }: {
  imports = [ ./custom/gnome.nix ];

  home.de.gnome = {
    enable = true;

    clockFormat = "12h";

    extensions = with pkgs.gnomeExtensions; [
      appindicator
      night-theme-switcher
    ];
  };
}

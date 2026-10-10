{ ... }: {
  imports = [ ./custom/gnome.nix ];

  home.de.gnome = {
    enable = true;
    clockFormat = "12h";
  };
}

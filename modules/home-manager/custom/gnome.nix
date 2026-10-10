{
  config,
  lib,
  ...
}:

let
  cfg = config.home.de.gnome;
in

{
  options.home.de.gnome = {
    enable = lib.mkEnableOption "Home Manager Gnome settings.";
    clockFormat = lib.mkOption {
      type = lib.types.enum [ "24h" "12h" ];
      default = "24h";
      description = "Tell Gnome to use 12-hour time for the clock module.";
    };
  };

  config = lib.mkIf cfg.enable {
    dconf.enable = true;

    dconf.settings."org/gnome/desktop/interface".clock-format = cfg.clockFormat;
  };
}

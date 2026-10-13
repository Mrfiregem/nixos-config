{
  config,
  lib,
  ...
}:

let
  cfg = config.home.de.gnome;

  normalizedExtensions = map (
    item: if lib.isDerivation item then { package = item; } else item
  ) cfg.extensions;
in

{
  options.home.de.gnome = {
    enable = lib.mkEnableOption "Home Manager Gnome settings.";
    clockFormat = lib.mkOption {
      type = lib.types.enum [
        "24h"
        "12h"
      ];
      default = "24h";
      description = "Tell Gnome to use 12-hour time for the clock module.";
    };
    extensions = lib.mkOption {
      type = lib.types.listOf (
        lib.types.either lib.types.package (
          lib.types.submodule {
            options = {
              package = lib.mkOption {
                type = lib.types.package;
                description = "The Gnome extension package.";
              };
              id = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "ID of the GNOME Shell extension.";
              };
            };
          }
        )
      );
      default = [ ];
      example = lib.literalExpression "[ pkgs.gnomeExtensions.dash-to-panel ]";
      description = "A list of Gnome extensions to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    dconf.enable = true;

    dconf.settings."org/gnome/desktop/interface".clock-format = cfg.clockFormat;

    programs.gnome-shell.enable = normalizedExtensions != [];
    programs.gnome-shell.extensions = normalizedExtensions;
  };
}

{ config, lib, ... }:

let
  cfg = config.home.de.gnome;

  extensionList = lib.types.listOf (
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
      type = extensionList;
      default = [ ];
      example = lib.literalExpression "[ pkgs.gnomeExtensions.dash-to-panel ]";
      description = "A list of Gnome extensions to install.";
    };
    usePointerCursor = lib.mkEnableOption "Configure Gnome to use the cursor theme defined in `home.PointerCursor`.";
    automaticLocation = lib.mkEnableOption "Allow programs to use your location.";
    wallpaper =
      let
        pathOption =
          kind:
          lib.mkOption {
            type = lib.types.path;
            description = "Path to the ${kind} theme wallpaper.";
            example = lib.literalExpression "./imgs/bg-${kind}.png";
          };
      in
      lib.mkOption {
        type = lib.types.submodule {
          options = {
            enable = lib.mkEnableOption "Set light and dark background images.";
            light = pathOption "light";
            dark = pathOption "dark";
          };
        };
      };
  };

  config = lib.mkIf cfg.enable {
    dconf.enable = true;

    dconf.settings = lib.mkMerge [
      # Settings here are always applied.
      {
        "org/gnome/system/location".enabled = cfg.automaticLocation;
        "org/gnome/desktop/interface".clock-format = cfg.clockFormat;
      }
      # These are applied only when condition is met.
      (lib.mkIf cfg.usePointerCursor {
        "org/gnome/desktop/interface" = {
          cursor-theme = config.home.pointerCursor.name;
          cursor-size = config.home.pointerCursor.size;
        };
      })
      (lib.mkIf cfg.wallpaper.enable {
        "org/gnome/desktop/background" = {
          picture-uri = "file://${cfg.wallpaper.light}";
          picture-uri-dark = "file://${cfg.wallpaper.dark}";
          picture-options = "zoom";
        };
      })
    ];

    programs.gnome-shell.enable = normalizedExtensions != [ ];
    programs.gnome-shell.extensions = normalizedExtensions;
  };
}

{
  lib,
  pkgs,
  nixosConfig,
  ...
}:

let
  host = nixosConfig.networking.hostName;
  expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options";
in

{
  # GUI code editor
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    extensions = [
      # Styling
      "catppuccin"
      "material-icon-theme"

      # Languages
      "emmet"
      "nix"
      "nu"

      # Other
      "typos"
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
    userSettings = {
      disable_ai = true;
      theme = {
        mode = "system";
        dark = "Catppuccin Macchiato";
        light = "Catppuccin Latte";
      };
      icon_theme = {
        mode = "system";
        dark = "Material Icon Theme";
        light = "Material Icon Theme";
      };
      format_on_save = "on";
      languages = {
        Nix = {
          # The Nix extension enables both by default, but
          # we don't have nil installed so we disable it here.
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [ ];
            };
          };
        };
      };
      lsp = {
        nixd = {
          binary = {
            path = (lib.getExe pkgs.nixd);
          };
          initialization_options = {
            formatting = {
              command = [ "nixfmt" ];
            };
            options = {
              nixos = {
                expr = expr;
              };
              home-manager = {
                expr = "${expr}.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };
}

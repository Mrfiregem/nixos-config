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
    extensions = [
      # Styling
      "catppuccin"
      "material-icon-theme"

      # Languages
      "nix"
      "nu"
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
    userSettings = {
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

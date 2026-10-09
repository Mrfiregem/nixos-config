# vim: et sw=2
{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}:
{
  # Home Manager boilerplate.
  home.username = "cheer";
  home.homeDirectory = "/home/cheer";
  home.stateVersion = "26.05";

  # Import from reusable modules
  imports = [
    ../../modules/home-manager/gnome.nix

    ../../modules/home-manager/git.nix
    ../../modules/home-manager/nushell.nix

    ../../modules/home-manager/spicetify.nix
  ];

  # Manage XDG base directories
  xdg.enable = true;

  # User packages.
  home.packages = with pkgs; [
    # CLI tools
    bat
    fd
    ffmpeg
    fzf
    htop
    lazygit
    mpv
    neovim
    ripgrep

    # GUI programs
    audacity
    discord
    firefox

    # Games
    wheelwizard
  ];

  # Program configurations.
  programs = {
    # Have Home Manager manage itself.
    home-manager.enable = true;

    # Configure shell prompt
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # Fish shell user configuration
    fish = {
      enable = true;
      functions = {
        nix-switch = {
          description = "Rebuild the NixOS configuration flake.";
          argumentNames = "action";
          body = ''
            set -q action[1]
            or set action 'switch'

            sudo nixos-rebuild --flake "$HOME/nixos-config#delphi" $action
          '';
        };
        mkcd = {
          description = "Create and switch to a new directory.";
          argumentNames = "path";
          body = "mkdir -p $path; cd $path";
        };
      };
    };

    # GUI code editor
    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
      extraPackages = with pkgs; [
        nixd
        nixfmt
      ];
      userSettings = {
        languages = {
          Nix = {
            # The Nix extension enables both by default, but
            # we don't have nil installed so we disable it here.
            language_servers = [
              "!nil"
              "nixd"
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
                  expr = "(builtins.getFlake \"${config.home.homeDirectory}/nixos-config\").nixosConfigurations.${nixosConfig.networking.hostName}.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake \"${config.home.homeDirectory}/nixos-config\").nixosConfigurations.${nixosConfig.networking.hostName}.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
        };
      };
    };
  };

  # Environment variables.
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };
}

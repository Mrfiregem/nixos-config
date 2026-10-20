# vim: et sw=2
{ pkgs, nixosConfig, constants, ... }:

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
    ../../modules/home-manager/zed.nix

    ../../modules/home-manager/spicetify.nix

    ../../modules/home-manager/gaming.nix
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
    wl-clipboard

    # GUI programs
    audacity

    # Art stuff
    aseprite
    krita
    inkscape
  ];

  # Ensure flatpaks are installed with nix-flatpak
  services.flatpak.packages = [
    {
      appId = "io.github.TeamWheelWizard.WheelWizard";
      origin = "flathub";
    }
    {
      appId = "org.qbittorrent.qBittorrent";
      origin = "flathub";
    }
  ];

  # Program configurations.
  programs = {
    # Have Home Manager manage itself.
    home-manager.enable = true;

    # GUI Programs
    firefox.enable = true;
    keepassxc.enable = true;
    discord.enable = true;

    # CLI Apps
    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = constants.git.name;
          email = constants.git.email;
        };
        ui.default-command = "log";
      };
    };

    jjui.enable = true;

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    # Games
    prismlauncher.enable = true;

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

            nixos-rebuild --sudo --flake "$HOME/nixos-config#${nixosConfig.networking.hostName}" $action
          '';
        };
        mkcd = {
          description = "Create and switch to a new directory.";
          argumentNames = "path";
          body = "mkdir -p $path; cd $path";
        };
      };
    };
  };

  # Environment variables.
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  # Use KDE Plasma cursor theme
  home.pointerCursor = {
    enable = true;
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}

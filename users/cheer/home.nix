# vim: et sw=2
{ pkgs, ... }:

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
  ];

  # Program configurations.
  programs = {
    # Have Home Manager manage itself.
    home-manager.enable = true;

    # Password manager
    keepassxc.enable = true;

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
  };

  # Environment variables.
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };
}

# vim: et sw=2
{ pkgs, ... }: {
  # Home Manager boilerplate.
  home.username = "cheer";
  home.homeDirectory = "/home/cheer";
  home.stateVersion = "26.05";

  # Import from reusable modules
  imports = [
    ../../modules/home-manager/gnome.nix

    ../../modules/home-manager/git.nix
    ../../modules/home-manager/nushell.nix
  ];

  # Manage XDG base directories
  xdg.enable = true;

  # User packages.
  home.packages = with pkgs; [
    # CLI tools
    fd
    fzf
    htop
    neovim
    ripgrep

    # GUI programs
    discord
    firefox

    # Games
    wheelwizard
  ];

  # Program configurations.
  programs = {
    # Have Home Manager manage itself.
    home-manager.enable = true;

    # Zsh user configuration.
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ls = "ls --classify=auto --color=auto";
        ll = "ls -l";
        la = "ls -la";
        grep = "grep --color=auto";
        diff = "diff --color=auto";

        nix-switch = "sudo nixos-rebuild switch --flake ~/nixos-config#delphi";
      };
    };

    # GUI code editor
    zed-editor = {
      enable = true;
      extraPackages = with pkgs; [
        nixd
        nixfmt
      ];
    };
  };

  # Environment variables.
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };
}

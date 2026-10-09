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
    ffmpeg
    fzf
    htop
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
      enableZshIntegration = true;
    };

    # Zsh user configuration.
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          command = "fg=cyan";
          builtin = "fg=cyan,bold";
          function = "fg=cyan,underline";
          alias = "fg=cyan,bold,underline";
        };
      };

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

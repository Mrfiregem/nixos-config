{
  flake.modules.homeManager.cliCorePackages = { pkgs, lib, ... }: {
    programs = {
      bat.enable = true; # Pager with syntax highlighting.
      btop.enable = true; # TUI Process monitor.
      fd.enable = true; # Ergonomic `find` replacement.
      fzf.enable = true; # Fuzzy finder.
      ripgrep.enable = true; # A `grep` replacement.
      tealdeer.enable = true; # Quick alternative to man pages.
      zoxide.enable = true; # Quickly navigate common folders.
    };

    home.packages = [
      pkgs.ffmpeg # A video editing CLI utility.
    ]
    ++ lib.lists.optional pkgs.stdenv.hostPlatform.isLinux pkgs.wl-clipboard;
  };
}

{
  flake.modules.homeManager.cliCorePackages = { pkgs, lib, ... }: {
    programs = {
      bat.enable = true;
      fd.enable = true;
      ripgrep.enable = true;
      fzf.enable = true;
      btop.enable = true;
    };

    home.packages = [
      pkgs.ffmpeg
    ]
    ++ lib.lists.optional pkgs.stdenv.hostPlatform.isLinux pkgs.wl-clipboard;
  };
}

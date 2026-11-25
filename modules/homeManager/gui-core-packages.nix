{
  flake.modules.homeManager.guiCorePackages = { pkgs, ... }: {
    programs = {
      firefox.enable = true;
      keepassxc.enable = true;
      mpv.enable = true;
    };

    home.packages = [
      (pkgs.discord.override {
        withMoonlight = true;
      })
    ];
  };
}

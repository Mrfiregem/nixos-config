{ self, ... }:
{
  flake.modules.homeManager.delphiUser = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      gnomeModule
      xdgDirs

      cliCorePackages
      guiCorePackages

      plasmaCursorTheme

      flatpakModule

      artTools
      fishShell
      ghostty
      git
      jujutsu
      mediaTools
      neovimEditor
      nushell
      spicetify
      starshipPrompt
      zedEditor
    ];

    # Home Manager boilerplate.
    home.username = "cheer";
    home.homeDirectory = "/home/cheer";
    home.stateVersion = "26.11";

    # Have Home Manager manage itself.
    programs.home-manager.enable = true;

    services.flatpak.packages = [
      "io.github.TeamWheelWizard.WheelWizard"
    ];

    home.packages = [ pkgs.marktext ];
  };
}

{ self, ... }:
{
  flake.modules.homeManager.delphiUser = {
    imports = with self.modules.homeManager; [
      gnomeModule
      xdgDirs

      cliCorePackages
      guiCorePackages

      plasmaCursorTheme

      flatpakModule
      delphiFlatpakConfig

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
  };

  flake.modules.homeManager.delphiFlatpakConfig = {
    services.flatpak.packages = [
      "io.github.TeamWheelWizard.WheelWizard"
    ];
  };
}

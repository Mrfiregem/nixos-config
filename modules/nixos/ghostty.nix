{
  flake.modules.nixos.ghostty = {
    config,
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.ghostty];

    # Make Ghostty the default terminal in Gnome.
    programs = lib.mkIf config.services.desktopManager.gnome.enable {
      # Set default terminal in file manager.
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "ghostty";
      };

      # Set Ghostty to open terminal apps by default.
      dconf.profiles.user.databases = [
        {
          settings."org/gnome/desktop/default-applications/terminal" = {
            exec = "ghostty";
            exec-arg = "-e";
          };
        }
      ];
    };
  };
}

{ pkgs, ... }:

{
  # Install Ghostty for all users.
  environment.systemPackages = [ pkgs.ghostty ];

  # Remove Gnome Console from default packages.
  # environment.gnome.excludePackages = [ pkgs.gnome-console ];

  # Configure Nautilus file manager to `Open in Terminal` with Ghostty.
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };

  # Change Gnome's default terminal setting.
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/default-applications/terminal" = {
        exec = "ghostty";
        exec-arg = "-e";
      };
    }
  ];
}

# vim: sw=2 et
{ pkgs, ... }:

{
  fonts = {
    # Install a set of defaults for coverage
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Extra unicode coverage
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      # Coding / Nerd Icons
      nerd-fonts.fira-code
    ];
  };
}

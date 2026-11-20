{
  flake.modules.homeManager.artTools = { pkgs, ... }: {
    home.packages = with pkgs; [
      aseprite # Pixel art editor.
      blender # 3D modeling software.
      inkscape # Vector art editor.
      kdePackages.kdenlive # Video editor.
      krita # 2D digital painting software.
    ];
  };
}

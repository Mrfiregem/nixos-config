{ self, lib, ... }:
{
  # Define constants here to use in any module.
  config.constants = {
    git = {
      user = "Firegem";
      email = "5158194+Mrfiregem@users.noreply.github.com";
    };
    wallpaper = {
      light = self + /assets/img/bg-light;
      dark = self + /assets/img/bg-dark;
    };
  };

  options.constants = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = { };
    description = "Top-level constants shared between modules.";
  };
}

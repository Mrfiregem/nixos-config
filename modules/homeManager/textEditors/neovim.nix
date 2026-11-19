{ inputs, ... }: {
  flake.modules.homeManager.neovimEditor = { pkgs, ... }: {
    home = {
      packages = [
        inputs.my-nvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
      };
    };

  };
}

{ config, ... }:
{
  flake.modules.homeManager.git = {
    programs = {
      git = {
        enable = true;

        # Global ignore patterns
        ignores = [
          ".DS_Store"
          "*.swp"
          "node_modules/"
          "env"
          ".env"
        ];

        # Other configuration options
        settings = {
          user.name = config.constants.git.user;
          user.email = config.constants.git.email;
          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };

      # Tool to work with Github.
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings = {
          git_protocol = "ssh";
          aliases = { };
        };
      };

      # TUI program to work with git repos.
      lazygit.enable = true;
    };
  };
}

# vim: et sw=2
{ constants, ... }: {
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
        user.name = constants.git.name;
        user.email = constants.git.email;
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        git_protocol = "ssh";
        aliases = { };
      };
    };
  };
}

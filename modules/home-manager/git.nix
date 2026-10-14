# vim: et sw=2
{ constants, ... }: {
  programs.git = {
    enable = true;

    settings = {
      user.name = constants.git.name;
      user.email = constants.git.email;
    };

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
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}

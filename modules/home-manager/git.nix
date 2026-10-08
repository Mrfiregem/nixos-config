# vim: et sw=2
{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "Firegem";
    userEmail = "5158194+Mrfiregem@users.noreply.github.com";
    
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

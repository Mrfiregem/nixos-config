{
  flake.modules.homeManager.starshipPrompt = { pkgs, ... }: {
    programs.starship = {
      enable = true;
      settings = {
        format = pkgs.lib.concatStrings [
          "$directory"
          "$vcs"
          "$nix_shell"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];
        vcs.order = [
          "jj"
          "git"
        ];
      };
    };
  };
}

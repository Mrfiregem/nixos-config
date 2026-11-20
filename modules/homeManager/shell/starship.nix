{
  flake.modules.homeManager.starshipPrompt = { pkgs, ... }: {
    programs.starship = {
      enable = true;
      settings = {
        command_timeout = 1000; # 1 second.
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

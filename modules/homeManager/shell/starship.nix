{
  flake.modules.homeManager.starshipPrompt = { pkgs, ... }: {
    programs.starship = {
      enable = true;
      settings = {
        command_timeout = 1000; # 1 second.
        vcs.order = [
          "jj"
          "git"
        ];
        format = pkgs.lib.concatStrings [
          "$directory"
          "$vcs"
          "$package"
          "$crystal"
          "$gleam"
          "$golang"
          "$lua"
          "$nim"
          "$nodejs"
          "$python"
          "$rust"
          "$nix_shell"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];
      };
    };
  };
}

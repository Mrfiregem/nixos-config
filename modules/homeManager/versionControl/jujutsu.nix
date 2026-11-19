top: {
  flake.modules.homeManager.jujutsu = {
    programs = {
      # A better version control system.
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = top.config.constants.git.user;
            email = top.config.constants.git.email;
          };
          ui.default-command = "log";
          aliases = {
            tug = [
              "bookmark"
              "advance"
              "--to"
              "@-"
            ];
          };
        };
      };

      # A TUI to work with jj repos.
      jjui.enable = true;

      # Use `delta` as the pager for `jj diff`.
      delta = {
        enable = true;
        enableJujutsuIntegration = true;
      };
    };
  };
}

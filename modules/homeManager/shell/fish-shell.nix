{
  flake.modules.homeManager.fishShell = { nixosConfig, ... }: {
    programs.fish = {
      enable = true;
      functions = {
        nix-switch = {
          description = "Rebuild the NixOS configuration flake.";
          argumentNames = "action";
          body = ''
            set -q action[1]
            or set action 'switch'

            nixos-rebuild --sudo --flake "$HOME/nixos-config#${nixosConfig.networking.hostName}" $action
          '';
        };
        mkcd = {
          description = "Create and switch to a new directory.";
          argumentNames = "path";
          body = "mkdir -p $path; cd $path";
        };
      };
    };
  };
}

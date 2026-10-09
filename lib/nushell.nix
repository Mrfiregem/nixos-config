{ lib, pkgs, ... }:

{
  # Create a Nushell script and place it on the PATH.
  writeNushellScriptBin =
    name: text:
    pkgs.writeTextFile {
      inherit name;
      executable = true;
      destination = "/bin/${name}";
      text = ''
        #!${lib.getExe pkgs.nushell}
        ${text}
      '';
      meta.mainProgram = name;
    };
}

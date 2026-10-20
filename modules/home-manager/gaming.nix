{ ... }:

{
  programs.retroarch = {
    enable = true;
    cores = {
      mgba.enable = true;
      melonds.enable = true;
      pcsx2.enable = true;
    };
  };
}

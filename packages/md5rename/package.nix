{ writers }:

writers.writeNuBin "md5rename" (builtins.readFile ./md5rename.nu)

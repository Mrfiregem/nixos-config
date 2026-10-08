# vim: et sw=2
{ pkgs, ... }: {
  programs.nushell = {
    enable = true;

    plugins = with pkgs.nushellPlugins; [
      query
      formats
      polars
    ];

    settings = {
      history = {
        file_format = "sqlite";
        isolation = true;
      };

      show_banner = false;

      highlight_resolved_externals = true;
      color_config = {
        shape_external = "red";
        shape_external_resolved = "cyan";
      };
    };

    extraConfig = ''
      # `cd` to the directory provided by stdin
      def --env cdl [
        --physical(-p) # Resolve symbolic links
        ...postfix: path # Additional paths to append to input
      ]: oneof<path, nothing> -> nothing {
        append $postfix
        | if $in == [] { $nu.home-dir } else { path join }
        | cd --physical=$physical $in
      }

      # Create a new directory and navigate to it
      def --env mkcd [path: path]: nothing -> nothing {
        mkdir $path; cd $path
      }
    '';
  };
}

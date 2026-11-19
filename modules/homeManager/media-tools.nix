{
  flake.modules.homeManager.mediaTools = { config, pkgs, ... }: {
    home.packages = [ pkgs.qbittorrent ];

    programs = {
      # Tool to download image galleries.
      gallery-dl = {
        enable = true;
        settings = {
          extractor = {
            # Where all files will be stored.
            base-directory = "${config.home.homeDirectory}/Pictures/gallery-dl";
            # Keep track of previously-downloaded files.
            archive = "${config.xdg.dataHome}/gallery-dl/archive.sqlite3";

            # Pull logins from browser storage.
            cookies = [ "firefox" ];
          };
        };
      };

      # Program to record and stream your screen.
      obs-studio.enable = true;

      # Tool to download videos from YouTube and other sites.
      yt-dlp.enable = true;
    };
  };
}

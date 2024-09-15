{ inputs, lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    yazi

    unar # Handle archives
    mediainfo # Display media information
    exiftool # Read EXIF metadata
  ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/yazi".source = ./yazi;
  };
  # home.file = {
  #   ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink ./yazi;
  # };
}

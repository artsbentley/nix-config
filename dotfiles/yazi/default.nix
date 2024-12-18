{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yazi

    unar # Handle archives
    mediainfo # Display media information
    exiftool # Read EXIF metadata
  ];

  programs.zsh.initExtra = ''
            path=("$HOME/.config/scripts" $path)
    		'';

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}






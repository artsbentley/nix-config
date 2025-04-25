{ inputs, lib, config, pkgs, ... }:
let
  program = "yazi";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  xdg.configFile."${program}".source = configSrc;

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
}






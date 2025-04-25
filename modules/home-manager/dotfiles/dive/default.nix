{ pkgs, lib, config, ... }:
let
  program = "dive";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  home.packages = [ pkgs.dive ];
  xdg.configFile."${program}".source = configSrc;
}



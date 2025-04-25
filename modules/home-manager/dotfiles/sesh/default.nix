{ pkgs, lib, config, ... }:
let
  program = "sesh";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  home.packages = [ pkgs.sesh ];
  xdg.configFile."${program}".source = configSrc;
}


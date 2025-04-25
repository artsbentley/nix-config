{ pkgs, lib, config, ... }:
let
  program = "stu";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  xdg.configFile."${program}".source = configSrc;
}


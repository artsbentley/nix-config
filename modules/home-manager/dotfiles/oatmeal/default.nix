{ pkgs, lib, config, ... }:
let
  program = "oatmeal";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  # home.packages = [ pkgs.aerospace ];
  xdg.configFile."${program}".source = configSrc;
}


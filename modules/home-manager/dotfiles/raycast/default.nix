{ pkgs, lib, config, ... }:
let
  program = "raycast";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
lib.mkIf pkgs.stdenv.isDarwin {
  xdg.configFile."${program}".source = configSrc;
}


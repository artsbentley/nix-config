{ pkgs, lib, config, ... }:
# let
#   program = "direnv";
#   filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
#   configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
# in
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  # home.packages = [ pkgs.direnv ];
  xdg.configFile."direnv/direnvrc".source = config.lib.file.mkOutOfStoreSymlink config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/direnv/direnv/direnvrc";
  xdg.configFile."direnv/direnv.toml".source = config.lib.file.mkOutOfStoreSymlink config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/direnv/direnv/direnv.toml";
}


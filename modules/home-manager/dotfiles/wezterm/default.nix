{ inputs, lib, config, pkgs, ... }:
let
  program = "wezterm";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  # home.packages = [ pkgs.aerospace ];
  xdg.configFile."${program}".source = configSrc;

  home.packages = with pkgs; [
    wezterm
  ];
  programs.wezterm = {
    enable = true;
    # enableFishIntegration = true;
    # enableZshIntegration = true;
  };
}

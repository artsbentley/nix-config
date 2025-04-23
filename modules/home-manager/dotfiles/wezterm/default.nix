{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wezterm
  ];
  programs.wezterm = {
    enable = true;
    enableFishIntegration = true;
    # enableZshIntegration = true;
  };
}

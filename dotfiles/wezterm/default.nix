{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wezterm
  ];
  programs.wezterm = {
    enable = true;
    # enableZshIntegration = true;
  };
  home.file = {
    ".config/wezterm".source = ./wezterm;
  };
}

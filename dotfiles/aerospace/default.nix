{ inputs, lib, config, pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   wezterm
  # ];
  # programs.wezterm = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };
  home.file = {
    ".config/aerospace/aerospace.toml".source = ./aerospace.toml;
  };
  homebrew.casks = [
    "nikitabobko/tap/aerospace"
  ];
}

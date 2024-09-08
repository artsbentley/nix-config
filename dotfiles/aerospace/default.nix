{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/aerospace".source = ./aerospace;
  };

  homebrew.casks = [
    "nikitabobko/tap/aerospace"
  ];
}

{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/aerospace".source = ./aerospace;
  };
}

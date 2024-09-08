{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/aerospace/aerospace.toml".source = ./aerospace.toml;
  };
}

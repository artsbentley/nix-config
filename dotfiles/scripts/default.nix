{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".local/bin" = {
      source = ./scripts;
      recursive = true;
    };
  };
}

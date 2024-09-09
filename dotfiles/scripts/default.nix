{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".local/bin" = {
      source = ./bin;
      recursive = true;
    };
  };
}

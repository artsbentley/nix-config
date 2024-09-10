{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/dive".source = ./dive;
  };
}


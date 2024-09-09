{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/raycast".source = ./raycast;
  };
}


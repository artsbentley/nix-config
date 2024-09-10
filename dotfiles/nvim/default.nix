{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/nvim".source = ./nvim;
  };
}



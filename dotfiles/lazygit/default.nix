{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lazygit
  ];
  # programs.lazygit = {
  #   enable = true;
  # };
  home.file = {
    ".config/lazygit".source = ./lazygit;
  };
}


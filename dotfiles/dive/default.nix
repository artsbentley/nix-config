{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
  ];
}


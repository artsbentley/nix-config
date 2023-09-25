{ config, pkgs, lib, ... }:
with lib;

{
  imports = [
    ./starship
    ./git
    ./shell
  ];
}


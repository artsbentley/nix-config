{ config, pkgs, lib, ... }:
with lib;

{
  programs.starship = {
    enable = true;
  };
}

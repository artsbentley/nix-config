{ config, pkgs, lib, ... }:
with lib;

{
  programs.yazi = {
    enable = true;
  };
}


{ config, pkgs, lib, ... }:
with lib;

{
  imports = [
    ./firefox.nix
  ];
}

{ config, pkgs, lib, ... }:
with lib;

{
  imports = [
    ./starship.nix
    ./yazi.nix
    ./git.nix
    ./zsh.nix
  ];

  # packages = with pkgs;
  #   [
  #     make
  #     curl
  #     gzip
  #     killall
  #     rar # includes unrar
  #     ripgrep
  #     wget
  #     libreoffice
  #     trash-cli
  #   ];

}

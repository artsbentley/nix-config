{ config, pkgs, lib, ... }:
with lib;

{
  imports = [
    ./starship.nix
    ./git.nix
    ./zsh.nix
  ];

  # packages = with pkgs;
  #   [
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

{ pkgs, lib, config, ... }:
# TODO:
# have logic here depending on machine what to import
{
  imports = [
    ./zsh/default.nix
    ./git/default.nix
    ./tmux/default.nix
    ./yazi/default.nix
    # ./hypr/default.nix

    ./direnv
    ./dive
    ./gh-dash
    ./lazygit
    ./neovim


    # TODO: only on darwin
    # darwin
    ./aerospace

    # ./symlink.nix
  ];
}

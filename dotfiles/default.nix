{ pkgs, lib, config, ... }:
# TODO:
# have logic here depending on machine what to import
{
  imports = [
    ./zsh/default.nix
    ./git/default.nix
    ./nvim/default.nix
    ./tmux/default.nix
    ./yazi/default.nix
    # ./hypr/default.nix

    ./symlink.nix
  ];
}

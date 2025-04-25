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
    ./nvim
    ./oatmeal
    ./rainfrog
    ./scripts
    ./sesh
    ./stu


    # TODO: only on darwin
    # darwin
    ./aerospace
    ./raycast

    # ./symlink.nix
  ];
}

{ pkgs, lib, config, ... }:
# TODO:
# have logic here depending on machine what to import
{
  imports = [
    ./zsh/default.nix
    ./git/default.nix
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
    ./tmux
    ./wezterm
    ./yazi


    # TODO: only on darwin
    # darwin
    ./aerospace
    ./raycast

    # ./symlink.nix
  ];
}

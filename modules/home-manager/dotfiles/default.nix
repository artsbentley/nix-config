{ pkgs, lib, config, ... }:
# TODO:
# have logic here depending on machine what to import
{
  imports = [
    # ./zsh/default.nix
    ./git/default.nix
    # ./hypr/default.nix

    ./shell
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
    ./bat



    # TODO: only on darwin
    # darwin
    ./aerospace
    ./raycast

    # TODO:
    # do hyprland and other desktop specific configuration
  ];
}

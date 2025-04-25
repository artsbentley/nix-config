{ inputs, pkgs, lib, config, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      # TODO: theme not working currently
      theme = "gruvbox-dark";
      # theme = if !pkgs.stdenv.isLinux then "gruvbox-dark" else null;
      italic-text = "always";
    };
  };
}

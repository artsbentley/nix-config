{ inputs, pkgs, lib, hostConfig, config, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      # TODO: theme not working currently
      theme = lib.mkIf (!hostConfig.enableStylix) "gruvbox-dark";
      # theme = if !pkgs.stdenv.isLinux then "gruvbox-dark" else null;
      italic-text = "always";
    };
  };
}

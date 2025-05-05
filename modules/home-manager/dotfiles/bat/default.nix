{ inputs, pkgs, lib, hostConfig, config, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = lib.mkIf (!hostConfig.enableStylix) "gruvbox-dark";
      italic-text = "always";
    };
  };
}

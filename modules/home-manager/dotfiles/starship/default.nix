{ inputs, pkgs, lib, config, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      systemd.disabled = true;
    };
  };
}

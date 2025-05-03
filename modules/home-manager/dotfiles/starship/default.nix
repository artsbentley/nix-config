{ inputs, pkgs, lib, config, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      container.disabled = true;
      username = {
        show_always = true;
      };
      hostname = {
        ssh_only = false;
      };
    };
  };
}

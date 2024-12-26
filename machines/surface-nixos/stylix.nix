{ pkgs, config, inputs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  stylix.targets = {
    waybar.enable = true;
    tmux.enable = false;
    yazi.enable = false;
    wezterm.enable = false;
    firefox.enable = true;
    gnome.enable = true;
    nixvim.enable = false;
    hyprland.enable = true;
  };
}

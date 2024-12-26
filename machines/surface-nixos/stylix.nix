{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    waybar
    hyprland
    hyprlock
    hypr
  ];
}

{
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

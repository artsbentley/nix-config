{ pkgs, config, inputs, ... }:
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  wayland.windowManager.hyperland.extraConfig = builtins.readFile ../../dotfiles/hypr/hypr/hyprland.conf;

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    # hyprland = {
    #   enable = true;
    # };
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

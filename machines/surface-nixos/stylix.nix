{ pkgs, config, inputs, ... }:
{
  wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  # wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../dotfiles/hypr/hypr/hyprland.conf;

  programs = {
    rofi.enable = true;
    waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
  stylix.targets = {
    tmux.enable = false;
    yazi.enable = false;
    wezterm.enable = false;

    waybar.enable = true;
    firefox.enable = true;
    gnome.enable = true;
    hyprland.enable = true;
    rofi.enable = true;
  };
  imports = [
    ../../dotfiles/hypr/default.nix
  ];
}

{ inputs, lib, config, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # NOTE: 
  # switch to xdg instead: xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  home.username = "arar";
  home.homeDirectory = "/home/arar";
  home.stateVersion = "23.11";
  #

  # TODO: 
  # organize by variables within the nix files itself; isLinux isPersonal isServer
  # place the collection of dotfiles in the dotfile directory itself
  # imports = [
  #   ../../dotfiles/zsh/default.nix
  #   ../../dotfiles/git/default.nix
  #   ../../dotfiles/nvim
  #   ../../dotfiles/tmux/default.nix # NOTE: now tmux is used for the server aswell
  #   ../../dotfiles/yazi/default.nix
  #   # ../../dotfiles/wezterm/default.nix
  #   ../../dotfiles/symlink.nix
  #   ./packages.nix
  # ];
  imports = [
    ../../dotfiles
    ./packages.nix
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}


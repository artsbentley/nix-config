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
  # TODO: wrap dotfiles directory location in variable
  # NOTE: better solution?
  # home.file."${config.xdg.configHome}" = {
  #   source = ../../dotfiles;
  #   recursive = true;
  # };

  home.file = {
    ".config/nvim".source = ../../dotfiles/nvim;
  };
  imports = [
    ../../dotfiles/zsh/default.nix
    ../../dotfiles/git/default.nix
    ../../dotfiles/scripts/default.nix
    ../../dotfiles/yazi/default.nix
    ../../dotfiles/lazygit/default.nix
    ./packages.nix

  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}


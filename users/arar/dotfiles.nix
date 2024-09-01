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
  # BUG:
  # this depends on the system, linux/ mac
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
    ".config/zsh/initExtra".source = ../../dotfiles/zsh/initExtra;
    ".config/nvim".source = ../../dotfiles/nvim;
    # ".config/starship".source = ~/dotfiles/starship;
  };

  imports = [
    ../../dotfiles/zsh/default.nix
    ./packages.nix
    ./gitconfig.nix
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}


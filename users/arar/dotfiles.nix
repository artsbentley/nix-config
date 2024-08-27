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

  home.username = "arar";
  home.homeDirectory = "/home/arar";
  home.stateVersion = "23.11";
  #
  # TODO: wrap dotfiles directory location in variable
  # TODO: put dotfiles in nix repo and use relative path below 

  # NOTE: better solution?
  # home.file."${config.xdg.configHome}" = {
  #   source = ../../dotfiles;
  #   recursive = true;
  # };

  home.file = {
    ".config/zsh/initExtra".source = ../../dotfiles/zsh/initExtra;
    ".config/nvim".source = ../../dotfiles/nvim;
    # ".config/wezterm".source = ~/dotfiles/wezterm;
    # ".config/skhd".source = ~/dotfiles/skhd;
    # ".config/starship".source = ~/dotfiles/starship;
    # ".config/nix".source = ~/dotfiles/nix;
    # ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    # ".config/tmux".source = ~/dotfiles/tmux;
  };

  imports = [
    ../../dotfiles/zsh/default.nix
    # ../../dotfiles/nvim/default.nix
    # ../../dotfiles/neofetch/default.nix
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


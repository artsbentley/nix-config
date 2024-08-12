{ inputs, lib, config, pkgs, ... }:
let
  home = {
    username = "arar";
    homeDirectory = "/home/arar";
    stateVersion = "23.11";
  };

in
{
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = home;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # TODO: put dotfiles in nix repo and use relative path below 
  # home.file = {
  #   ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
  #   ".config/wezterm".source = ~/dotfiles/wezterm;
  #   ".config/skhd".source = ~/dotfiles/skhd;
  #   ".config/starship".source = ~/dotfiles/starship;
  #   ".config/nvim".source = ~/dotfiles/nvim;
  #   ".config/nix".source = ~/dotfiles/nix;
  #   ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
  #   ".config/tmux".source = ~/dotfiles/tmux;
  # };

  imports = [
    ../../dots/zsh/default.nix
    # ../../dots/nvim/default.nix
    # ../../dots/neofetch/default.nix
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


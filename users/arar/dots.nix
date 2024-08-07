{ inputs, lib, config, pkgs, ... }:
let
  # nixpkgs = {
  #   overlays = [ ];
  #   config = {
  #     allowUnfree = true;
  #     allowUnfreePredicate = (_: true);
  #   };
  # };
in
{
  home.username = "arar";
  home.homeDirectory = "/Users/arar";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # TODO: put dotfiles in nix repo and use relative path below 
  home.file = {
    ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
    ".config/wezterm".source = ~/dotfiles/wezterm;
    ".config/skhd".source = ~/dotfiles/skhd;
    ".config/starship".source = ~/dotfiles/starship;
    ".config/zellij".source = ~/dotfiles/zellij;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/nix".source = ~/dotfiles/nix;
    ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    ".config/tmux".source = ~/dotfiles/tmux;
  };

  imports = [
    ../../dots/zsh/default.nix
    ../../dots/nvim/default.nix
    ../../dots/neofetch/default.nix
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


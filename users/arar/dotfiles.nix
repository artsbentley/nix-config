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


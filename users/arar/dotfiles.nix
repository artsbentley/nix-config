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
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    gh
    tmux
    yazi
    # direnv
    # atuin
    wget
    xclip
    htop
    sops
    neofetch
    # nerdfonts
    nodejs
    luarocks
    unzip
    templ
    ruff
    d2
    golangci-lint
    wezterm
  ];
}


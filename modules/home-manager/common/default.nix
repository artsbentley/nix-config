{ inputs, lib, config, pkgs, userConfig, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
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

  home.username = userConfig.name;
  home.homeDirectory =
    if isDarwin then
      "/Users/${userConfig.name}"
    else
      "/home/${userConfig.name}";

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.home-manager.enable = true;

  # import modules instead of directly installing packages here
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    # direnv
    # atuin
    wget
    # xclip
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


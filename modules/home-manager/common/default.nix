{ inputs, lib, config, pkgs, userConfig, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  imports =
    [
      ../dotfiles/atuin
      ../dotfiles/bat
      ../dotfiles/direnv
      ../dotfiles/dive
      ../dotfiles/gh-dash
      ../dotfiles/git
      ../dotfiles/lazygit
      ../dotfiles/nvim
      ../dotfiles/oatmeal
      ../dotfiles/rainfrog
      ../dotfiles/scripts
      ../dotfiles/sesh
      ../dotfiles/shell
      ../dotfiles/starship
      ../dotfiles/stu
      ../dotfiles/tmux
      ../dotfiles/wezterm
      ../dotfiles/yazi
      ../dotfiles/zoxide
      # DARWIN
      ../dotfiles/aerospace
      ../dotfiles/raycast
    ];

  # TODO: desktop 
  # ./hypr/default.nix
  #

  # FIX: 
  # use dedicated stylix module and set some to only enable for desktop
  # enabled
  stylix.targets = {
    tmux.enable = false;
    yazi.enable = false;
    bat.enable = true;
    wezterm.enable = true;

    # waybar.enable = true;
    # firefox.enable = true;
    # gnome.enable = true;
    # hyprland.enable = true;
    # rofi.enable = true;
  };


  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Home-Manager configuration for the user's home environment
  home.username = userConfig.name;
  home.homeDirectory =
    if isDarwin
    then "/Users/${userConfig.name}"
    else "/home/${userConfig.name}";

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.home-manager.enable = true;

  # import modules instead of directly installing packages here
  home.packages = with pkgs; [
    # direnv
    # atuin
    # xclip
    htop
    sops
    neofetch
    # nerdfonts
    nodejs
    luarocks
    templ
    ruff
    d2
    golangci-lint
    wezterm
    lazydocker
    lazygit
    # CLI
    yazi
    neovim
    go
    gh
    tmux
    wget
    unzip
    eza
    fd
    ripgrep
    jq
  ]
  # Ensure common packages are installed
  ++ lib.optionals isDarwin [
    colima
    docker
    hidden-bar
    raycast
    # orbstack
  ]
  ++ lib.optionals (!isDarwin) [
    pavucontrol
    pulseaudio
    tesseract
    unzip
    wl-clipboard
  ];
}


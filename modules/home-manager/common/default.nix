{ inputs, lib, config, pkgs, userConfig, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  imports = [
    ../dotfiles
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  xdg.configFile = {
    "test.txt".source = config.lib.file.mkOutOfStoreSymlink "~/nix-config/dotfiles/test/test.txt";
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
    orbstack
  ]
  ++ lib.optionals (!isDarwin) [
    pavucontrol
    pulseaudio
    tesseract
    unzip
    wl-clipboard
  ];
}


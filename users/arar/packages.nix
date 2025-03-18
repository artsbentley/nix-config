{ pkgs, ... }: {
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
    # templ
    ruff
    d2
    golangci-lint
    wezterm
  ];
}

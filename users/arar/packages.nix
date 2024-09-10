{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    direnv
    # atuin
    wget
    htop
    sops
    neofetch
  ];
}

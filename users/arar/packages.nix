{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    direnv
    # atuin
    wget
    xclip
    htop
    sops
    neofetch
  ];
}

{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    # atuin
    wget
    htop
    sops
  ];
}

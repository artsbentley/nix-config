{ pkgs, zen-browser, ... }: {
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    zen-browser.packages.x86_64-linux.zen-browser
    direnv
    # atuin
    wget
    htop
    sops
    neofetch
  ];
}

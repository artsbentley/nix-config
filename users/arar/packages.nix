{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    tmux
    yazi
    jq
    # atuin
  ];
}

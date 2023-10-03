{ config, pkgs, lib, ... }:
with lib;

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "zoxide"
        "make"
        # "zsh-autosuggestions"
        # "zsh-syntax-highlighting"
        # "zsh-fast-syntax-highlighting"
        # "zsh-autocomplete"
      ];
      theme = "robbyrussell";
    };
    # enableCompletion = true;
    # enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      "vim" = "nvim";
      "v" = "nvim";
      ".." = "cd ..";
      "c" = "clear";
      "l" = "exa -lbF -l --icons -a --git";
      "update" = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#arar";
    };
    #histSize = 10000;
    #histFile = "${config.xdg.dataHome}/zsh/history";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Gruvbox";
      italic-text = "always";
    };
  };
}

{ config, pkgs, lib, ... }:
with lib;

{
  programs.zsh = {
    enable = true;
    #dotDir = ".config/zsh";
    shellAliases = {
      "vim" = "nvim";
      "v" = "nvim";
      ":GoToFile" = "nvim +GoToFile";


      ".." = "cd ..";
      "c" = "clear";
      "l" = "exa -lbF -l --icons -a --git";
      "update" = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#arar";
    };
    #histSize = 10000;
    #histFile = "${config.xdg.dataHome}/zsh/history";
  };
}

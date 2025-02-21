{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs;
    [
      tmux
    ];
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 1000000;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = lib.strings.fileContents ./tmux.conf;
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      fzf-tmux-url
      jump
      yank
      tmux-thumbs
      tmux-floax
      resurrect
      continuum
    ];
  };
}




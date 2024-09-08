{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  home.file = {
    ".config/tmux/tmuxconfig.conf".source = ../../dotfiles/tmux/tmuxconfig.conf;
  };
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

    # TODO: 
    # proper home dir
    # extraConfig = ''source-file ~/.config/tmux/tmuxconfig.conf'';

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      fzf-tmux-url
      yank
      tmux-thumbs
      t-smart-tmux-session-manager
    ];
  };
}




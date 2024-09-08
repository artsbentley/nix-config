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
    sensibleOnTop = false;
    # TODO: 
    # proper home dir
    extraConfig = ''source-file ~/.config/tmux/tmuxconfig.conf'';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      fzf-tmux-url
      yank
      tmux-thumbs
      t-smart-tmux-session-manager
    ];
  };
}




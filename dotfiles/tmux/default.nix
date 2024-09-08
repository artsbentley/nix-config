{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    extraConfig = ''
            set -g base-index 1           # start indexing windows at 1 instead of 0
            set -g detach-on-destroy off  # don't exit from tmux when closing a session 
            set -g escape-time 0          # zero-out escape time delay
            set -g history-limit 1000000  # significantly increase history size
            set -g mouse on               # enable mouse support
            set -g renumber-windows on    # renumber all windows when any window is closed
            set -g set-clipboard on       # use system clipboard
            set -g status-interval 2      # update status every 2 seconds
            set -g status-left-length 200 # increase status line length
            set -g status-position top    # macOS / darwin style
            # set -g status-right '        # empty

            set - g status-left                  '#[fg=blue,bold]#S'
            # set -ga status-left                 '#[fg=white,nobold]#(gitmux -timeout 200ms -cfg $HOME/.config/tmux/gitmux.conf) '
            # set -g status-left '#[fg=blue,bold]#S #[fg=white,bold]#(gitmux -timeout 200ms -cfg $HOME/.config/tmux/gitmux.conf) #(basename "$(pwd)") / #(basename "$(dirname "$(pwd)")") |'
            # set -g status-left '#[fg=blue,bold]#S #[fg=pink,bold]#(gitmux -timeout 200ms -cfg $HOME/.config/tmux/gitmux.conf) #(basename "$(pwd)") / #(basename "$(dirname "$(pwd)")") / #(git rev-parse --show-toplevel | xargs basename) |'

      		set - g pane-active-border-style     'fg=magenta,bg=default'
      		set -g pane-border-style            'fg=brightblack,bg=default'
      		set -g status-style                 'bg=default' # transparent
      		set -g window-status-current-format '#[fg=magenta] *#W '
      		set -g window-status-format         '#[fg=gray] #W '

      		# set-option -g automatic-rename-format '#(tmux-icon-name #{pane_current_command})'
      		set-option -g default-terminal        'screen-256color'
      		set-option -g terminal-overrides      ',xterm-256color:RGB'

      		# give tmux panel a prefix when zoomed in 
      		tmux_conf_theme_focused_pane_bg="green"
      		tmux_conf_theme_highlight_focused_pane=false
      		tmux_conf_theme_window_status_format="#I #W#{?window_bell_flag,🔔,}#{?window_zoomed_flag,🔍,}"
      		tmux_conf_theme_window_status_current_format="#I #W#{?window_zoomed_flag,🔍,}"
      		#
      		bind '%' split-window -c '#{pane_current_path}' -h
      		bind c   new-window   -c '#{pane_current_path}'
      		bind '"' split-window -c '#{pane_current_path}' -l 30%

      unbind C-G
      bind G   new-window   -n '' lazygit
      bind -r g popup -d '#{pane_current_path}' -E -w 95% -h 95% lazygit

      unbind C-d
      bind d   new-window   -n '' lazydocker


      bind-key < swap-window -t -
      bind-key > swap-window -t +
      bind-key l last-window
      # bind -r l select-pane -l

      # Resizing panes
      # Use meta-ctrl-hjkl to resize panes
      bind-key -T M-C-h resize-pane -L 
      bind-key -T M-C-j resize-pane -D 
      bind-key -T M-C-k resize-pane -U 
      bind-key -T M-C-l resize-pane -R 


      bind-key -T copy-mode-vi 'C-\' select-pane -l
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'v'   send-keys -X begin-selection
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt (cmd+w)

      set -g @fzf-url-fzf-options '-w 50% -h 50% --prompt="   " --border-label=" Open URL "'
      set -g @fzf-url-history-limit '2000'
      set -g @fzf-url-open-command 'open'


      #tmux thumbs
      unbind F
      set -g @thumbs-key F
      set -g @thumbs-command 'tmux set-buffer -w "{}"'
      set -g @thumbs-upcase-command 'tmux set-buffer -w "{}" && tmux paste-buffer'
      set -g @thumbs-alphabet colemak-homerow


      # tmux yanking + vim mode
      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # set -g status-right '#(gitmux "#{pane_current_path}")'
          # set -ga status-left " #[fg=white,nobold]#(gitmux -cfg $HOME/.config/tmux/gitmux.yml)"

          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'christoomey/vim-tmux-navigator'
          set -g @plugin 'schasse/tmux-jump'
          set -g @jump-key 's'


          unbind J
          # BUG: currently not working
          bind-key "J" display-popup "wkt"

          # TODO: migrte to sesh V2
          bind-key "T" run-shell "sesh connect $(
      	sesh list -tz | fzf-tmux -p 40%,40% \
      		--no-sort --border-label ' sesh ' --prompt '⚡  ' \
      		--header '  ^a all ^t tmux ^x zoxide ^f find' \
      		--bind 'tab:down,btab:up' \
      		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
      		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
      		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
      		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
      )"

          # set -g @plugin 'joshmedeski/t-smart-tmux-session-manager'
          set -g @plugin 'joshmedeski/tmux-fzf-url'
          set -g @plugin 'tmux-plugins/tmux-yank'
          set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
          set -g @plugin 'fcsonline/tmux-thumbs'

          # enable yazi image preview
          set -g allow-passthrough on
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      tmux-fzf-url
      yank
      tmux-thumbs
    ];
  };
}




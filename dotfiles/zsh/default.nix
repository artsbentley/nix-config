{ inputs, pkgs, lib, config, ... }: {
  home.packages = with pkgs; [
    grc
    bat
  ] ++ (if pkgs.stdenv.isLinux then [
    # TODO: clean this up with variables/ extraspecial args
    # nerd-fonts.jetbrains-mono
  ] else [ ]);

  fonts.fontconfig.enable = true;


  home.file = {
    ".config/zsh/initExtra".source = ./initExtra;
  };


  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        dialect = "uk";
        filter_mode_shell_up_key_binding = "session";
        # workspaces = true;
        invert = true;
        style = "compact";
        inline_height = 16;
        enter_accept = false;
        ctrl_n_shortcuts = true;
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      # sessionVariables = {
      #   OPENAI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets.openaiApiKey.path})'';
      # };

      # TODO: move to another solution for plugins, see https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file
      zplug = {
        enable = true;
        plugins = [
          # { name = "jeffreytse/zsh-vi-mode"; }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-syntax-highlighting"; }
          { name = "zsh-users/zsh-completions"; }
          { name = "zsh-users/zsh-history-substring-search"; }
          { name = "unixorn/warhol.plugin.zsh"; }
          # { name = "arar/prompt"; tags = [ as:theme ]; }
        ];
      };
      # NOTE: this might not work properly if home manager is symlinking all .config
      # directories
      dotDir = ".config/zsh";
      shellAliases = {
        la = "ls --color -lha";
        l = "${pkgs.eza}/bin/eza --group-directories-first -lbF -l --icons -a --git --sort=type --color=always";
        lt = "${pkgs.eza}/bin/eza --color=auto --tree";
        cal = "cal -m";
        cat = "bat";
        grep = "rg --color=auto";
        df = "df -h";
        # du = "du -ch";
        fd = "fd --color=auto";
        ipp = "curl ipinfo.io/ip";
        vi = "nvim";
        vim = "nvim";
        mkdir = "mkdir -p";
        home = "cd ~";
        c = "clear";
        ":Yazi" = "ya";
        rsyncb = "rsync -av --ignore-existing --info=progress2";

        # GIT 
        gpl = "git pull --rebase --autostash";
        ghinit = "gh repo create $(basename '$PWD ') --private --source=. --remote=origin";

        stopdocker = "sudo systemctl stop --all 'podman-*' && podman builder prune -f -a && podman network prune -f && podman image prune -a -f && podman container prune -f";
        startdocker = "sudo systemctl start --all 'podman-*'";
        # update = "cd ~/nix-config && git pull && sudo nixos-rebuild switch --flake .#arar && cd -";

        ".." = "cd ..";
        "..." = "cd ../..";

      };
      # TODO: need to decide if i want to continue this route or just implement
      #  config in .zsh files
      initExtra = ''
        		  zmodload zsh/zprof
        		  bindkey -v
        		  bindkey "^?" backward-delete-char
        		  bindkey "^H" backward-delete-char
        		  if [ $(uname) = "Darwin" ]; then 
        			path=("$HOME/.nix-profile/bin" "/run/wrappers/bin" "/etc/profiles/per-user/$USER/bin" "/nix/var/nix/profiles/default/bin" "/run/current-system/sw/bin" "/opt/homebrew/bin" $path)
        		  fi

        		  for conf in "$HOME/.config/zsh/initExtra/"*.zsh; do source "$conf"; done; unset conf

        		  export EDITOR=nvim || export EDITOR=vim
        		  export LANG=en_US.UTF-8
        		  export LC_CTYPE=en_US.UTF-8
        		  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
        		  export XDG_CONFIG_HOME="$HOME/.config"
      '';




      # TODO: add bitwarden CLI tooling and secrets to make bw_session env var work 

      #initExtra = ''
      #  # Cycle back in the suggestions menu using Shift+Tab
      #  bindkey '^[[Z' reverse-menu-complete

      #  bindkey '^B' autosuggest-toggle
      #  # Make Ctrl+W remove one path segment instead of the whole path
      #  WORDCHARS=''${WORDCHARS/\/}

      #  # Highlight the selected suggestion
      #  zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      #  zstyle ':completion:*' menu yes=long select

      #    if [ $(uname) = "Darwin" ]; then 
      #      path=("$HOME/.nix-profile/bin" "/run/wrappers/bin" "/etc/profiles/per-user/$USER/bin" "/nix/var/nix/profiles/default/bin" "/run/current-system/sw/bin" "/opt/homebrew/bin" $path)
      #      export BW_SESSION=$(${pkgs.coreutils}/bin/cat ${config.age.secrets.bitwardenSession.path})
      #      export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock" 
      #    fi
      #
      #    export EDITOR=nvim || export EDITOR=vim
      #    export LANG=en_US.UTF-8
      #    export LC_CTYPE=en_US.UTF-8
      #    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES


      #    if [ $(uname) = "Darwin" ]; then 
      #      alias lsblk="diskutil list"
      #      ulimit -n 2048
      #    fi 

      #    source $ZPLUG_HOME/repos/unixorn/warhol.plugin.zsh/warhol.plugin.zsh
      #    bindkey '^[[A' history-substring-search-up
      #    bindkey '^[[B' history-substring-search-down

      #    if command -v motd &> /dev/null
      #    then
      #      motd
      #    fi
      #    bindkey -e
      #'';
    };
  };
  programs.bat = {
    enable = true;
    config = {
      # TODO: theme not working currently
      theme = "gruvbox-dark";
      # theme = if !pkgs.stdenv.isLinux then "gruvbox-dark" else null;
      italic-text = "always";
    };
  };
}




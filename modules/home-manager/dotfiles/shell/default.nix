{ inputs, pkgs, lib, config, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  shellAliases = {

    # Aliases: editor
    vi = "nvim";
    vim = "nvim";

    # Aliases: ls
    la = "ls --color -lha";
    l = "${pkgs.eza}/bin/eza --group-directories-first -lbF -l --icons -a --git --sort=type --color=always";
    lt = "${pkgs.eza}/bin/eza --color=auto --tree";

    # Aliases: system
    cal = "cal -m";
    cat = "bat";
    grep = "rg --color=auto";
    df = "df -h";
    # du = "du -ch";
    fd = "fd --color=auto";
    ipp = "curl ipinfo.io/ip";
    mkdir = "mkdir -p";
    home = "cd ~";
    mhome = "cd /Users/arar";
    c = "clear";
    ":Yazi" = "ya";
    rsyncb = "rsync -av --ignore-existing --info=progress2";
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme default";
    nup = "cd ~/nix-config/ && just && cd -";

    # Aliases: systemd
    jd = "journalctl --no-pager";

    # Aliases: git
    gs = "git status --short";
    gc = "git commit";
    gcl = "git clone";
    gl = "git log --graph --all --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n'";
    gd = "git diff";
    gn = "git checkout -b";
    gco = "git checkout";
    ga = "git add";
    gpl = "git pull --rebase --autostash";
    ghinit = "gh repo create --private --source=. --remote=origin
";
    gfo = "git fetch origin --prune";

    # Aliases: docker
    dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
    dl = "docker logs --tail=100";
    stopdocker = "sudo systemctl stop --all 'podman-*' && podman builder prune -f -a && podman network prune -f && podman image prune -a -f && podman container prune -f";
    startdocker = "sudo systemctl start --all 'podman-*'";
    # update = "cd ~/nix-config && git pull && sudo nixos-rebuild switch --flake .#arar && cd -";

    ".." = "cd ..";
    "..." = "cd ../..";

  };

  translatedSessionVariables = pkgs.runCommandLocal "hm-session-vars.fish" { } ''
    (echo "function setup_hm_session_vars;"
    ${pkgs.buildPackages.babelfish}/bin/babelfish \
    <${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh
    echo "end"
    echo "setup_hm_session_vars") > $out
  '';

in
{
  xdg.enable = true;

  # TODO: move these to nixpkgs instead of home manager
  home.packages = [
    pkgs.bat
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.gopls
    pkgs.grc
    pkgs.htop
    pkgs.jq
    pkgs.ripgrep
    pkgs.sentry-cli
    pkgs.tree
    pkgs.watch
  ] ++ (lib.optionals isDarwin [
    pkgs.cachix
  ]) ++ (lib.optionals isLinux [
    # TODO: clean this up with variables/ extraspecial args
    # pkgs.nerd-fonts.jetbrains-mono
  ]);

  home.sessionVariables = {
    EDITOR = "nvim";
    # neeeded for rust ssl:
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
  fonts.fontconfig.enable = true;

  # NOTE: no longer needed with fish
  # home.file = {
  #   ".config/zsh/initExtra".source = ./initExtra;
  # };


  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "nix-env.fish";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          };
        }
      ];
      shellAliases = shellAliases;
      interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
        (builtins.readFile ./config.fish)
        "set -g SHELL ${pkgs.fish}/bin/fish"
        "source ${translatedSessionVariables}"
      ]));
      # loginShellInit =
      #   # Nix
      #   ''
      #     if test - e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      #       source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      #       end
      #       # End Nix
      #   '';

      #   let
      #     # We should probably use `config.environment.profiles`, as described in
      #     # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
      #     # but this takes into account the new XDG paths used when the nix
      #     # configuration has `use-xdg-base-directories` enabled. See:
      #     # https://github.com/LnL7/nix-darwin/issues/947 for more information.
      #     profiles = [
      #       "/etc/profiles/per-user/$USER" # Home manager packages
      #       "$HOME/.nix-profile"
      #       "(set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)/nix/profile"
      #       "/run/current-system/sw"
      #       "/nix/var/nix/profiles/default"
      #     ];
      #
      #     makeBinSearchPath =
      #       lib.concatMapStringsSep " " (path: "${path}/bin");
      #   in
      #   ''
      #     # Fix path that was re-ordered by Apple's path_helper
      #     fish_add_path --move --prepend --path ${makeBinSearchPath profiles}
      #     set fish_user_paths $fish_user_paths
      #   '';
    };

    zsh = {
      enable = false;
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
      shellAliases = shellAliases;
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
        		  export EDITOR=nvim || export EDITOR=vim
        		  export LANG=en_US.UTF-8
        		  export LC_CTYPE=en_US.UTF-8
        		  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
        		  export XDG_CONFIG_HOME="$HOME/.config"

        		  for conf in "$HOME/.config/zsh/initExtra/"*.zsh; do source "$conf"; done; unset conf
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
}




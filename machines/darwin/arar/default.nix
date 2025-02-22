{ inputs, pkgs, lib, ... }:
{
  environment.shellInit = ''
    ulimit -n 2048
  '';

  imports = [
    ./system.nix
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = false;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };

    taps = [
      # "noahgorstein/tap/jqp"
      "morantron/tmux-fingers"
      "julien-cpsn/atac"
      "nikitabobko/aerospace"
      "joshmedeski/sesh"
      # "dustinblackman/oatmeal"
      # {
      #   name = "zen-browser/browser";
      #   clone_target = "https://github.com/zen-browser/desktop.git";
      #   force_auto_update = true;
      # }
    ];

    # TODO: 
    # check which need to be in a brew and which can be managed by HM input
    brews = [
      "atlas"
      "atuin"
      "automake"
      "azure-cli"
      "bacon"
      "bash"
      "bat"
      "bitwarden-cli"
      "bazel"
      "certbot"
      "cmake"
      "cmatrix"
      "coursier"
      "crystal"
      "curl"
      "dbmate"
      "direnv"
      "dive"
      "elixir"
      "exercism"
      "eza"
      "fd"
      "fx"
      "fzf"
      "gh"
      "git"
      "git-delta"
      "gitmoji"
      "gleam"
      "gnu-sed"
      "go"
      "golang-migrate"
      "goose"
      "gopls"
      "gum"
      "htop"
      "hugo"
      "hurl"
      "joshmedeski/sesh/sesh"
      "jq"
      "just"
      "lazydocker"
      "lazygit"
      "lf"
      "librdkafka"
      "mas"
      "mise"
      "mosquitto"
      "neovim"
      "ninja"
      "ollama"
      "openjdk@11"
      # "openssl@1.1"
      "openssl"
      "pipx"
      "python@3.10"
      "ripgrep"
      "rsyslog"
      "rust"
      "rustup"
      "s3cmd"
      "sshs"
      "starship"
      "step"
      "sqlc"
      "strongswan"
      "syncthing"
      "taskwarrior-tui"
      "tree"
      "vite"
      "watchexec"
      "xcodegen"
      "yazi"
      "yq"
      "zig"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "dustinblackman/tap/oatmeal"
      "uv"
      "postgresql"
      "garrettkrohn/treekanga/treekanga"
      "prettier"
      "marp-cli"
      "age"
      "gnupg"
      "zigup"
    ];

    casks = [
      # "zen-browser"
      "nikitabobko/tap/aerospace"
      "telegram"
      "signal"
      "karabiner-elements"
      "grid"
      "monitorcontrol"
      "google-chrome"
      "handbrake"
      "tailscale"
      "bambu-studio"
      "element"
      "bambu-studio"
      "arc"
      "balenaetcher"
      "bitwarden"
      "bruno"
      "cyberduck"
      "eqmac"
      "font-hack-nerd-font"
      "google-drive"
      "hammerspoon"
      "keepassxc"
      "loop"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "orbstack"
      "postman"
      "raycast"
      "sf-symbols"
      "thonny"
      "vlc"
      "vnc-viewer"
      "wezterm"
      "syncthing"
      "obsidian"
      "discord"
      "drawio"
      "cursor"
      "qbittorrent"
    ];
  };

  environment.systemPackages = with pkgs; [
    (python311Full.withPackages (ps: with ps; [
      pip
      jmespath
      requests
      setuptools
      pyyaml
    ]))
    ansible-language-server
    git-lfs
    pre-commit
    bfg-repo-cleaner
    go
    gotools
    go-outline
    gopkgs
    gocode-gomod
    godef
    golint
    colima
    docker
    docker-compose
    utm
    wget
    git-crypt
    iperf3
    deploy-rs
    neofetch
    tmux
    rsync
    nmap
    sqlite
    pwgen
    gnupg
    inputs.agenix.packages."${system}".default
    # inputs.zen-browser.packages."${system}".zen-browser
    # bitwarden-cli
    yt-dlp
    ffmpeg
    chromedriver
    mosh
    git-filter-repo
    spotify
    httpie
    slack
    mattermost
    google-cloud-sdk
    pinentry.curses
    nixos-rebuild
    direnv
    prettierd
    clipboard-jh
    bun
    gitAndTools.gitflow
    gh-dash
  ];

  services.nix-daemon.enable = lib.mkForce
    true;

  system.stateVersion = 4;
}

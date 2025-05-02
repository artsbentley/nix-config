{ inputs, pkgs, lib, hostConfig, ... }:
{
  ids.gids.nixbld = 350;
  environment.shellInit = ''
    ulimit -n 2048
  '';

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
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
    ];

    # TODO: 
    # check which need to be in a brew and which can be managed by HM input
    brews = [
      "age"
      "atlas"
      "atuin"
      "automake"
      "awscli"
      "azure-cli"
      "bacon"
      "bash"
      "bat"
      "bazel"
      "bitwarden-cli"
      "certbot"
      "cmake"
      "cmatrix"
      "coursier"
      "crystal"
      "curl"
      "dbmate"
      "direnv"
      "dive"
      "dustinblackman/tap/oatmeal"
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
      "gnupg"
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
      "jwt-cli"
      "lazydocker"
      "lazygit"
      "lf"
      "librdkafka"
      "lusingander/tap/stu"
      "marp-cli"
      "mas"
      "mise"
      "mosquitto"
      "neovim"
      "ninja"
      "ollama"
      "openjdk@11"
      "openssl"
      "pipx"
      "postgresql"
      "prettier"
      "python@3.13"
      "rainfrog"
      "ripgrep"
      "rsyslog"
      "rust"
      "rustup"
      "s3cmd"
      "sqlc"
      "sshs"
      "starship"
      "step"
      "strongswan"
      "syncthing"
      "templ"
      "tree"
      "uv"
      "vite"
      "watchexec"
      "xcodegen"
      "yazi"
      "yq"
      "zig"
      "zigup"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      # "openssl@1.1"
    ];

    casks = [
      "bitwarden"
      "bruno"
      "cursor"
      "cyberduck"
      "discord"
      "drawio"
      "element"
      "eqmac"
      "font-hack-nerd-font"
      "google-chrome"
      "grid"
      "hammerspoon"
      "handbrake"
      "karabiner-elements"
      "keepassxc"
      "loop"
      "microsoft-auto-update"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "monitorcontrol"
      "nikitabobko/tap/aerospace"
      "obsidian"
      "orbstack"
      "postman"
      "raycast"
      "sf-symbols"
      "signal"
      "syncthing"
      "tailscale"
      "telegram"
      "thonny"
      "vlc"
      "vnc-viewer"
      "wezterm"
      "xquartz"
      # "zen-browser"
    ]
    ++ lib.optionals hostConfig.isWorkMachine [
      "microsoft-teams"
    ]
    ++ lib.optionals (!hostConfig.isWorkMachine) [
      "qbittorrent"
      "google-drive"
      "balenaetcher"
      "autodesk-fusion"
      "bambu-studio"
    ];

  };

  environment.systemPackages = with pkgs; [
    # (python311Full.withPackages (ps: with ps; [
    #   pip
    #   jmespath
    #   requests
    #   setuptools
    #   pyyaml
    # ]))
    nix-search-tv
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
}

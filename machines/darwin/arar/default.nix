{ inputs, pkgs, lib, ... }:
{
  environment.shellInit = ''
    ulimit -n 2048
  '';

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };


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
      # "dustinblackman/tap/oatmeal"
      "elixir"
      "exercism"
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
      "htop"
      "hurl"
      "joshmedeski/sesh/sesh"
      "julien-cpsn/atac"
      "just"
      "lazydocker"
      "lazygit"
      "lf"
      "librdkafka"
      "mas"
      "mise"
      "morantron/tmux-fingers"
      "mosquitto"
      "neovim"
      "ninja"
      "noahgorstein/jqp"
      "ollama"
      "openjdk@11"
      "openssl@1.1"
      "pipx"
      "python@3.10"
      "qmk/qmk/qmk"
      "rsyslog"
      "rust"
      "rustup"
      "s3cmd"
      "sbt"
      "scala"
      "spotify-tui"
      "sshs"
      "starship"
      "step"
      "strongswan"
      "taskwarrior-tui"
      "tree"
      "vite"
      "watchexec"
      "xcodegen"
      "yazi"
      # "zig"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "notion"
      "telegram"
      "libreoffice"
      "signal"
      "karabiner-elements"
      "grid"
      "monitorcontrol"
      "google-chrome"
      "handbrake"
      "tailscale"
      # "bambu-studio" FAILED
      "element"
      "nikitabobko/aerospace"
      "alacritty"
      "arc"
      "balenaetcher"
      "bitwarden"
      "bruno"
      "cyberduck"
      "eqmac"
      "font-hack-nerd-font"
      "font-sf-mono-nerd-font"
      "google-drive"
      "hammerspoon"
      "keepassxc"
      "loop"
      # "lulu"
      # "microsoft-auto-update"
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
    vault
    yq
    git-lfs
    pre-commit
    bfg-repo-cleaner
    go
    gotools
    gopls
    go-outline
    gopls
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
    eza
    neofetch
    tmux
    rsync
    nmap
    jq
    yq
    ripgrep
    sqlite
    pwgen
    gnupg
    inputs.agenix.packages."${system}".default
    bitwarden-cli
    yt-dlp
    ffmpeg
    chromedriver
    mosh
    discord
    git-filter-repo
    spotify
    httpie
    slack
    mattermost
    sentry-cli
    vscode
    google-cloud-sdk
    pinentry.curses
    nixos-rebuild
  ];

  services.nix-daemon.enable = lib.mkForce true;

  system.stateVersion = 4;
}

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
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;

    };

    taps = [
      # "noahgorstein/tap/jqp"
      # "dustinblackman/tap/oatmeal"
      "morantron/tmux-fingers"
      "julien-cpsn/atac"
    ];

    # TODO: 
    # check which need to be in a brew and which can be managed by HM input
    brews = [
      "eza"
      "atlas"
      "atuin"
      "automake"
      "azure-cli"
      "bacon"
      "joshmedeski/sesh/sesh"
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
      "elixir"
      "exercism"
      "fd"
      "fx"
      "fzf"
      "gh"
      "yq"
      "jq"
      "git"
      "git-delta"
      "gitmoji"
      "gleam"
      "gnu-sed"
      "go"
      "gopls"
      "golang-migrate"
      "goose"
      "htop"
      "hurl"
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
      "openssl@1.1"
      "pipx"
      "python@3.10"
      "qmk/qmk/qmk"
      "rsyslog"
      "rust"
      "ripgrep"
      "rustup"
      "s3cmd"
      "sbt"
      "scala"
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
      "nikitabobko/tap/aerospace"
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
      "bambu-studio"
      "element"
      "bambu-studio"
      "alacritty"
      "arc"
      "balenaetcher"
      "bitwarden"
      # "bitwarden-cli"
      "bruno"
      "cyberduck"
      "eqmac"
      "font-hack-nerd-font"
      "font-sf-mono-nerd-font"
      "google-drive"
      "hammerspoon"
      "keepassxc"
      "loop"
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
    # bitwarden-cli
    yt-dlp
    ffmpeg
    chromedriver
    mosh
    # discord
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

  services.nix-daemon.enable = lib.mkForce
    true;

  system.stateVersion = 4;
}

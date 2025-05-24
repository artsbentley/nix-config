{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}:
{
  # Nixpkgs configuration
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.stable-packages
    # ];

    #     NOTE: research NUR overlay and if we want it?
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);

    };
  };

  # STYLIX
  stylix = lib.mkIf hostConfig.enableStylix {
    enable = true;
    base16Scheme = ../../../theme/gruvbox.yml;
  };

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  # stylix.autoEnable = false;


  nix.settings = {
    experimental-features = lib.mkDefault [ "nix-command flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "${userConfig.name}" ];
  };

  age.identityPaths = [
    "/home/${userConfig.name}/.ssh/arar"
    "/home/${userConfig.name}/.ssh/id_rsa"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];


  # Register flake inputs for nix commands
  nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) (lib.filterAttrs (_: lib.isType "flake") inputs);

  # Add inputs to legacy channels
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  powerManagement.powertop.enable = true;


  # Networking
  networking = {
    useDHCP = lib.mkForce true;
    # networkmanager.enable = true;
    hostId = "0730ae51";
    networkmanager.enable = false;
    firewall = {
      allowedTCPPorts = [ 5357 8000 8080 ];
      allowedUDPPorts = [ 3702 8000 8080 ];
      allowPing = true;
      trustedInterfaces = [ "enp1s0" ];
    };
  };

  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Input settings
  services.libinput.enable = true;

  # xserver settings
  services.xserver = lib.mkIf (!hostConfig.isHomelab) {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    displayManager.gdm.enable = true;
  };

  # PATH configuration
  environment.localBinInPath = true;

  # Disable CUPS printing
  services.printing.enable = false;

  # Enable devmon for device management
  services.devmon.enable = true;

  # Enable PipeWire for sound
  services.pulseaudio.enable = false;

  security = {
    rtkit.enable = true;
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      # Passwordless sudo
      wheelNeedsPassword = lib.mkDefault false;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User configuration
  # TODO: special configuration for homelab host
  users = {
    users.${userConfig.name} = {
      group = userConfig.name;
      description = userConfig.fullName;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "lxd"
        "users"
        "video"
        "podman"
        "share"
      ];
      isNormalUser = true;
      shell = pkgs.fish;
    };
    groups = {
      ${userConfig.name} = {
        gid = 1000;
      };
    };
  };

  # Set User's avatar
  # system.activationScripts.script.text = ''
  #   mkdir -p /var/lib/AccountsService/{icons,users}
  #   cp ${userConfig.avatar} /var/lib/AccountsService/icons/${userConfig.name}
  #
  #   touch /var/lib/AccountsService/users/${userConfig.name}
  #
  #   if ! grep -q "^Icon=" /var/lib/AccountsService/users/${userConfig.name}; then
  #     if ! grep -q "^\[User\]" /var/lib/AccountsService/users/${userConfig.name}; then
  #       echo "[User]" >> /var/lib/AccountsService/users/${userConfig.name}
  #     fi
  #     echo "Icon=/var/lib/AccountsService/icons/${userConfig.name}" >> /var/lib/AccountsService/users/${userConfig.name}
  #   fi
  # '';


  # System packages
  # TODO: add more conditionals if the hostConfig is a homelab
  environment.systemPackages = with pkgs; [
    cargo
    eza
    gcc
    gcc
    glances
    glib
    gnumake
    go
    go-outline
    gocode-gomod
    godef
    golint
    gopkgs
    gopls
    gotools
    hd-idle
    hddtemp
    hdparm
    inputs.agenix.packages."${system}".default
    iotop
    iperf3
    jq
    killall
    lm_sensors
    lua-language-server
    marksman
    mesa
    moreutils
    ncdu
    neovim
    nix-search-tv
    pciutils
    powertop
    python313
    restic
    ripgrep
    rsync
    ruff
    rustc
    sesh
    smartmontools
    sqlite
    stow
    stylua
    tmux
    wget
    just
    dig
    docker
    openssl
    pkg-config
    mkcert
    wezterm

    # maybe only for non VM?
    usbutils
    udiskie
    udisks
  ]
  # TODO: 
  # expand or decide that this should go in a dedicated module such as
  ++ (lib.optionals (pkgs.system == "x86_64-linux") [
    intel-gpu-tools
    cpufrequtils
  ])
  # "homelab"
  ++ lib.optionals hostConfig.isHomelab [ ]
  # NON-HOMELAB
  ++ lib.optionals (!hostConfig.isHomelab) [
    watchexec
    rainfrog
    zig
    rust-analyzer
    gh-dash
    jnv # json viewer

    # JAVASCRIPT
    nodejs_23
    # nodePackages.orval
    yarn
    vite
    tslib
    bun

    uv
    goose
    libpq

    bacon
    rustfmt
    rusty-man

    erlang
    gleam
    beam27Packages.rebar
    beam27Packages.rebar3
  ];

  # DOCKER
  virtualisation = lib.mkIf (!hostConfig.isHomelab) {
    docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
      storageDriver = "overlay2";
    };
  };

  system.autoUpgrade.enable = true;

  # shell configuration
  # programs.zsh.enable = true;
  programs.fish.enable = true;

  # enable git 
  programs.git.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # nerd-fonts.meslo-lg
    # roboto
  ];


  # USB hdd
  # TODO: only if hostname != orbstack
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Additional services
  services.locate.enable = true;

  # OpenSSH daemon
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}



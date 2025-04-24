{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}: {
  # Nixpkgs configuration
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.stable-packages
    # ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);

    };
  };

  nix.settings = {
    experimental-features = lib.mkDefault [ "nix-command flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "arar" ];
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


  # Boot settings
  boot = lib.mkIf (hostConfig.name != "orbstack") {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [ "quiet" "splash" ];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    plymouth.enable = true;

    # v4l (virtual camera) module settings
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Input settings
  services.libinput.enable = true;

  # xserver settings
  services.xserver = {
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
  security.rtkit.enable = true;
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

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # System packages
  # TODO: add more conditionals if the hostConfig is a homelab
  environment.systemPackages = with pkgs; [
    gcc
    jq
    glib
    gnumake
    inputs.agenix.packages."${system}".default
    iperf3
    killall
    mesa
    neovim
    python313
    ripgrep
    rsync
    sqlite
    wget
    nodejs
    go
    cargo
    rustc
    stow
    nix-search-tv
    ruff
    stylua
    lua-language-server
    marksman
    restic
    sesh

    # maybe only for non VM?
    usbutils
    udiskie
    udisks
  ]
  # TODO: 
  # expand or decide that this should go in a dedicated module such as
  # "homelab"
  ++ lib.optionals hostConfig.isHomelab [
  ]
  ++ lib.optionals (!hostConfig.isHomelab) [
    rainfrog
  ];

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

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

  # Additional services
  services.locate.enable = true;

  # OpenSSH daemon
  services.openssh.enable = true;


}



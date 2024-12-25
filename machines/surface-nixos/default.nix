{ inputs, config, pkgs, lib, ... }:
{
  # load module config to top-level configuration
  #

  system.stateVersion = "24.11";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # NOTE: 
  # seeing if this improves performance
  services.xserver = {
    vaapiDrivers = [ pkgs.intel-vaapi-driver ];
    videoDrivers = [ "modesetting" ];
  };
  hardware.opengl.enable = true;

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      libva
      libva-utils
    ];
  };


  # NOTE: 
  # seeing if this prevents screen flicker
  boot.kernelParams = [
    "i915.enable_psr=0" # Disable Panel Self Refresh
    "i915.enable_fbc=0" # Disable Framebuffer Compression
    "i915.enable_guc=2" # Enable GuC for better power management
  ];


  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
    ];
    dates = "06:00";
    randomizedDelaySec = "45min";
  };


  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  users.users = {
    root = {
      # initialHashedPassword = config.age.secrets.hashedUserPassword.path;
      # openssh.authorizedKeys.keys = [ "sshKey_placeholder" ];
    };
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
    # ports = [ 69 ];
    # hostKeys = [
    #   {
    #     path = "/persist/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    #   {
    #     path = "/persist/ssh/ssh_host_rsa_key";
    #     type = "rsa";
    #     bits = 4096;
    #   }
    # ];
  };

  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

  services.automatic-timezoned.enable = true;
  services.localtimed.enable = true;

  programs.git.enable = true;
  programs.mosh.enable = true;
  programs.htop.enable = true;

  # USB hdd
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # nerd-fonts
  fonts.fontDir.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/arar/nix-config";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };


  # prevent machine from sleeping
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  # Hyprland
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];



  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "arar";

  programs.firefox.enable = true;



  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };
  environment.systemPackages = with pkgs; [
    wget
    iperf3
    eza
    neofetch
    (python310.withPackages (ps: with ps; [ pip ]))
    tmux
    rsync
    iotop
    ncdu
    nmap
    jq
    ripgrep
    sqlite
    inputs.agenix.packages."${system}".default
    lm_sensors
    jc
    moreutils
    lsof
    fatrace
    git-crypt
    bfg-repo-cleaner
    deploy-rs
    wezterm
    sesh
    uv

    # Hyprland
    hyprland
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    hyprpicker
    hyprsunset
    hyprgraphics
    blueman
    nwg-look
    wlogout
    waybar
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    dunst
    rofi-wayland
    networkmanagerapplet
    pavucontrol
    pamixer


    # sound
    pipewire
    # wireplumber

    brightnessctl

    # USB harddrive
    usbutils
    udiskie
    udisks

    # applications
    signal-desktop
    discord
    bitwarden
  ];

}





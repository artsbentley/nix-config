{ inputs, config, pkgs, lib, ... }:
{
  # load module config to top-level configuration
  #

  system.stateVersion = "22.11";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

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
  time.timeZone = "Europe/Paris";

  programs.git.enable = true;
  programs.mosh.enable = true;
  programs.htop.enable = true;

  # USB hdd
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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

    # USB harddrive
    usbutils
    udiskie
    udisks

    nodejs
    nodePackages.prettier
    nodePackages.prettier-plugin-jinja-template
  ];

}



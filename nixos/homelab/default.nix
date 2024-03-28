# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, sops-nix, lib, config, pkgs, ... }: {
  imports = [
    # ./modules/arr.nix
    ./modules/nixarr.nix
    ./modules/syncthing.nix
    # ./modules/network.nix

    #NOTE this is used for combining home-manager into one
    # inputs.home-manager.nixosModules.home-manager
  ];


  #NOTE this is used for combining home-manager into one
  # home manager
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     arar = import ../home-manager/home.nix;
  #   };
  # };



  # System packages
  environment.systemPackages = with pkgs;
    [
      vim
      jq
      yq
      jqp
      wget
      zsh
      just
      git
      cryptsetup
      home-manager
      gnumake
      nfs-utils
      cifs-utils
      qbittorrent
      unzip
      dpkg
    ];

  # NOTE: test to try out
  # services.containers.enable = true;

  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };



  fileSystems."/export/nas" = {
    device = "/mnt/test";
    options = [ "bind" ];
  };
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export         *(rw,sync,no_subtree_check)
  '';

  services.nfs.server = {
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };
  networking.firewall = {
    enable = true;
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };

  # /export/kotomi  192.168.1.10(rw,nohide,insecure,no_subtree_check) 192.168.1.15(rw,nohide,insecure,no_subtree_check)

  # boot.initrd = {
  #   supportedFilesystems = [ "nfs" ];
  #   kernelModules = [ "nfs" ];
  # };
  fileSystems."/mnt/nas" = {
    device = "192.168.2.11:/mnt/nas/server/data";
    fsType = "nfs";
  };

  # fileSystems."/mnt/nas" =
  #   {
  #     device = "//192.168.2.5/nas";
  #     fsType = "cifs";
  #     options = [ "username=nixos" "password=nixos" "x-systemd.automount" "noauto" "uid=arar" "gid=100" ];
  #     # options = [ "guest" "x-systemd.automount" "noauto" ];
  #   };

  # default shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  users.users.arar.shell = pkgs.zsh;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # PROXMOX needs grub
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # create user group
  users.users.yourname = {
    isSystemUser = true;
    group = "arar";
  };
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.arar = {
    isNormalUser = true;
    description = "arar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
  users.groups.arar = { };

  # Enable automatic login for the user.
  services.getty.autologinUser = "arar";


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "nixos";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

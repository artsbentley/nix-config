{ modformfulesPath, inputs, networksLocal, lib, config, vars, pkgs, ... }:
{
  # users = {
  #   groups.share = {
  #     # gid = 993;
  #     gid = 1010;
  #   };
  #   users.share = {
  #     # uid = 994;
  #     uid = 1010;
  #     isSystemUser = true;
  #     group = "share";
  #   };
  # };
  # users.users.arar.extraGroups = [ "share" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking = {
    hostName = "nixos";
    #timeZone = "Europe/Berlin";
    # hostId = "0730ae51";
    # useDHCP = true;
    networkmanager.enable = lib.mkForce true;
    firewall = {
      allowedTCPPorts = [ 5357 ];
      allowedUDPPorts = [ 3702 ];
      allowPing = true;
      trustedInterfaces = [ "enp1s0" ];
    };
  };

  # TODO: add NAS if needed
  # fileSystems."${vars.homelabNasMount}" =
  #   {
  #     device = "//192.168.1.123/servermount";
  #     fsType = "cifs";
  #     options =
  #       let
  #         automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #       in
  #       [ "${automount_opts},credentials=${config.age.secrets.smbCredentials.path},uid=1010,gid=1010,file_mode=0775,dir_mode=0775" ];
  #   };
  #
  # fileSystems."${vars.rootNasMount}" =
  #   {
  #     device = "//192.168.1.123/rootmount";
  #     fsType = "cifs";
  #     options =
  #       let
  #         automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #       in
  #       [ "${automount_opts},credentials=${config.age.secrets.smbCredentials.path},uid=1010,gid=1010,file_mode=0775,dir_mode=0775" ];
  #   };


  powerManagement.powertop.enable = true;

  virtualisation.docker.storageDriver = "overlay2";
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    glances
    hdparm
    hd-idle
    hddtemp
    smartmontools
    go
    gotools
    gopls
    go-outline
    gopkgs
    gocode-gomod
    godef
    golint
    powertop
    cpufrequtils
    gnumake
    gcc
    intel-gpu-tools
    lazygit
    gum
    fzf
  ];
}



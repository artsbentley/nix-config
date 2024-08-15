{ modulesPath, inputs, networksLocal, lib, config, vars, pkgs, ... }:
{
  users = {
    groups.share = {
      gid = 993;
    };
    users.share = {
      uid = 994;
      isSystemUser = true;
      group = "share";
    };
  };
  users.users.arar.extraGroups = [ "share" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


  networking = {
    hostName = "nixos";
    #timeZone = "Europe/Berlin";
    hostId = "0730ae51";
    useDHCP = true;
    networkmanager.enable = false;
    firewall = {
      allowedTCPPorts = [ 5357 ];
      allowedUDPPorts = [ 3702 ];
      allowPing = true;
      trustedInterfaces = [ "enp1s0" ];
    };
  };

  fileSystems."/home/arar/backupshare" =
    {
      device = "//192.168.1.123/backupshare";
      fsType = "cifs";
      # options = [ "username=share" "password=share" "x-systemd.automount" "noauto" "uid=1000" "gid=991" ];
      # options = [ "guest" "x-systemd.automount" "noauto" ];
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        in
        [ "${automount_opts},credentials=${config.age.secrets.smbCredentials.path}" ];
    };




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
  ];
}



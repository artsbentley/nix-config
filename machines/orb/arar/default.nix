{ modformfulesPath, inputs, networksLocal, lib, config, vars, pkgs, ... }:
{
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;

  networking = {
    hostName = "nixos";
    #timeZone = "Europe/Berlin";
    hostId = "0730ae51";
    # useDHCP = true;
    networkmanager.enable = false;
    firewall = {
      allowedTCPPorts = [ 5357 ];
      allowedUDPPorts = [ 3702 ];
      allowPing = true;
      trustedInterfaces = [ "enp1s0" ];
    };
  };

  # powerManagement.powertop.enable = true;
  # virtualisation.docker.storageDriver = "overlay2";
  # system.autoUpgrade.enable = true;

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
    gnumake
    gcc
  ];
}



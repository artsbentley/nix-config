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


  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  # NOTE: remove all below if it doesnt work
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/b5160afe-16b2-4ec3-bab0-ee17491e3485";
      fsType = "ext4";
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # boot.kernelModules = [ "coretemp" "jc42" "lm78" "f71882fg" ];
  # hardware.cpu.intel.updateMicrocode = true;
  # hardware.enableRedistributableFirmware = true;
  # hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  # boot.zfs.forceImportRoot = true;
  # motd.networkInterfaces = lib.lists.singleton "enp1s0";
  # zfs-root = {
  #   boot = {
  #     devNodes = "/dev/disk/by-id/";
  #     bootDevices = [ "ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K" ];
  #     immutable = false;
  #     availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];

  #     removableEfi = true;
  #     kernelParams = [
  #       "pcie_aspm=force"
  #       "consoleblank=60"
  #       "acpi_enforce_resources=lax"
  #     ];
  #     sshUnlock = {
  #       enable = false;
  #       authorizedKeys = [ ];
  #     };
  #   };
  # };

  # imports = [
  #   ./backup
  # ];

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


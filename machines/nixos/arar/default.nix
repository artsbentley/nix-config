{ modulesPath, inputs, networksLocal, lib, nixpkgs, config, vars, pkgs, ... }:
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


  nix.registry.nixpkgs.flake = nixpkgs;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  # https://github.com/NixOS/nix/issues/9574
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs


  # boot.kernelModules = [ "
    coretemp " "
    jc42 " "
    lm78 " "
    f71882fg " ];
  # hardware.cpu.intel.updateMicrocode = true;
  # hardware.enableRedistributableFirmware = true;
  # hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  # boot.zfs.forceImportRoot = true;
  # motd.networkInterfaces = lib.lists.singleton "
    enp1s0 ";
    # zfs-root = {
    #   boot = {
    #     devNodes = "/dev/disk/by-id/";
    #     bootDevices = [ "
    ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K " ];
  #     immutable = false;
  #     availableKernelModules = [ "
    uhci_hcd " "
    ehci_pci " "
    ahci " "
    sd_mod " "
    sr_mod " ];

  #     removableEfi = true;
  #     kernelParams = [
  #       "
    pcie_aspm=force"
  #       "consoleblank=60"
  #       "acpi_enforce_resources=lax"
  #     ];
  #     sshUnlock = {
  #       enable = false;
  #       authorizedKeys = [ ];
  #     };
  #   };
  # };

  networking = {
    hostName = "arar";
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




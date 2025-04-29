{ inputs
, hostname
, nixosModules
, userConfig
, hostConfig
, system
, ...
}: {
  imports = [
    # inputs.nixos-hardware.nixosModules.common-cpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    "${nixosModules}/common"
    # "${nixosModules}/homelab"
    # "${nixosModules}/filemount"
    # "${nixosModules}/backup"
    # "${nixosModules}/programs/syncthing"
    # "${nixosModules}/programs/tailscale"
  ];

  # Set hostname
  networking.hostName = hostname;
  nixpkgs.hostPlatform = system;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‚Äòs perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  #
  system.stateVersion = "24.11";
}


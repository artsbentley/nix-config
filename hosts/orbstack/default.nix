{ inputs
, hostname
, nixosModules
, system
, ...
}: {
  imports = [
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-amd
    # inputs.hardware.nixosModules.common-pc-ssd
    # ./hardware-configuration.nix

    "${nixosModules}/common"
    ./orbstack.nix
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


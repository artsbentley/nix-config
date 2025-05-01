{ inputs
, hostname
, darwinModules
, userConfig
, hostConfig
, system
, ...
}: {
  imports = [
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-pc-ssd
    # ./hardware-configuration.nix
    # ./bootloader.nix

    "${darwinModules}/common"
    "${darwinModules}/brew"

  ];

  system.stateVersion = 6;

  # Set hostname
  # networking.hostName = hostname;
  # nixpkgs.hostPlatform = system;
}


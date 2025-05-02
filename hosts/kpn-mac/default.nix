{ inputs
, hostname
, darwinModules
, userConfig
, hostConfig
, system
, ...
}: {
  imports = [
    "${darwinModules}/common"
    "${darwinModules}/brew"
  ];

  networking.hostName = hostname;
  system.stateVersion = 6;
}



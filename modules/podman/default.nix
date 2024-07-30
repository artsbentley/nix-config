{ config, pkgs, ... }: {

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    extraPackages = [ pkgs.zfs ];
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  virtualisation.oci-containers = {
    backend = "podman";
  };
  networking.firewall.interfaces.podman0.allowedUDPPorts = [
    1900
    8080
    9090
    7359 # Discovery
  ];
  networking.firewall.interfaces.podman0.allowedTCPPorts = [
    8096
    8920 # Web frontend
    7878
    8989
    9696
    8384
    9090
    8080
  ];
  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920 # Web frontend
      7878
      8989
      9696
      8384
      9090
      8080
    ];
    allowedUDPPorts = [
      1900
      8080
      9090
      7359 # Discovery
    ];

  };
}


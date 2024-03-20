{ config, pkgs, ... }:

{
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



  services = {
    jellyfin = {
      enable = true;
      package = pkgs.jellyfin; # Upgrade to 10.6.x
    };

    prowlarr = {
      enable = true;
    };

    radarr = {
      enable = true;
      package = pkgs.radarr;
      user = "arar";
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      package = pkgs.sonarr;
      user = "arar";
      openFirewall = true;
    };
  };
}


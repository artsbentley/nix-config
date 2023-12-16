# { config, pkgs, ... }:


#   # Jellyfin
#   virtualisation.oci-containers.containers."jellyfin" = {
#     autoStart = true;
#     image = "jellyfin/jellyfin";
#     volumes = [
#       "/media/Containers/Jellyfin/config:/config"
#       "/media/Containers/Jellyfin/cache:/cache"
#       "/media/Containers/Jellyfin/log:/log"
#       "/media/Movies:/movies"
#       "/media/TV-Series:/tv"
#     ];
#     ports = [ "8096:8096" ];
#     environment = {
#       JELLYFIN_LOG_DIR = "/log";
#     };
#   };
#
# }
{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920 # Web frontend
      7878
      8989
    ];
    allowedUDPPorts = [
      1900
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
      package = pkgs.unstable.prowlarr;
    };

    radarr = {
      enable = true;
      package = pkgs.radarr;
    };

    sonarr = {
      enable = true;
      package = pkgs.sonarr;
    };
  };
}


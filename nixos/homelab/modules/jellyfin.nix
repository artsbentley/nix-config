{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920 # Web frontend
    ];
    allowedUDPPorts = [
      1900
      7359 # Discovery
    ];

    # Jellyfin
    virtualisation.oci-containers.containers."jellyfin" = {
      autoStart = true;
      image = "jellyfin/jellyfin";
      # volumes = [
      #   "/media/Containers/Jellyfin/config:/config"
      #   "/media/Containers/Jellyfin/cache:/cache"
      #   "/media/Containers/Jellyfin/log:/log"
      #   "/media/Movies:/movies"
      #   "/media/TV-Series:/tv"
      # ];
      ports = [ "8096:8096" ];
      environment = {
        JELLYFIN_LOG_DIR = "/log";
      };
    };

  }#
# { config, pkgs, ... }:
#
# {
#   networking.firewall = {
#     allowedTCPPorts = [
#       8096
#       8920 # Web frontend
#     ];
#     allowedUDPPorts = [
#       1900
#       7359 # Discovery
#     ];
#   };
#
#   services.jellyfin =
#     {
#       enable = true;
#       package = pkgs.jellyfin; # Upgrade to 10.6.x
#     };
# }

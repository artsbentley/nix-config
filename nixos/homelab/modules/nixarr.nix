{ config, pkgs, nixarr, ... }:

{
  nixarr = {
    enable = true;
    # These two values are also the default, but you can set them to whatever
    # else you want
    mediaDir = "/home/arar/data/media";
    # stateDir = "~/data/media/.state";

    vpn.enable = false;

    jellyfin.enable = true;
    transmission.enable = false;

    # It is possible for this module to run the *Arrs through a VPN, but it
    # is generally not recommended, as it can cause rate-limiting issues.
    sonarr.enable = true;
    radarr.enable = true;
    prowlarr.enable = true;
    readarr.enable = true;
    lidarr.enable = true;
  };
}

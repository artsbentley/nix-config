{ config, pkgs, nixarr, ... }:

{
  }  nixarr = {
    enable = true;
    # These two values are also the default, but you can set them to whatever
    # else you want
    mediaDir = "/home/arar/data/media";
    stateDir = "/home/arar/data/media/.state";
    # stateDir = "/data/media/.state";

    vpn = {
      enable = false;
      # IMPORTANT: This file must _not_ be in the config git directory
      # You can usually get this wireguard file from your VPN provider
      #wgConf = "/data/.secret/wg.conf";
    };

    jellyfin = {
      enable = false;
      # These options set up a nginx HTTPS reverse proxy, so you can access
      # Jellyfin on your domain with HTTPS
      expose.https = {
        enable = false;
        #domainName = "your.domain.com";
        #acmeMail = "your@email.com"; # Required for ACME-bot
      };
    };

    transmission = {
      enable = false;
      #vpn.enable = true;
      #peerPort = 50000; # Set this to the port forwarded by your VPN
    };

    # It is possible for this module to run the *Arrs through a VPN, but it
    # is generally not recommended, as it can cause rate-limiting issues.
    sonarr.enable = false;
    radarr.enable = false;
    prowlarr.enable = false;
    readarr.enable = false;
    lidarr.enable = false;
  };;
}
{ inputs, lib, config, pkgs, vars, ... }:
let
  # shareUid = toString config.users.users.share.uid;
  # shareGid = toString config.users.groups.share.gid;

  directories = [
    "${vars.serviceConfigRoot}/portainer"
    "${vars.serviceConfigRoot}/jellyfin"
    "${vars.serviceConfigRoot}/jellyfin/cache"
    "${vars.serviceConfigRoot}/jellyfin/config"
    "${vars.serviceConfigRoot}/jellyseerr"
    "${vars.serviceConfigRoot}/sonarr"
    "${vars.serviceConfigRoot}/radarr"
    "${vars.serviceConfigRoot}/prowlarr"
    "${vars.serviceConfigRoot}/recyclarr"
    "${vars.serviceConfigRoot}/bazarr"
    "${vars.nasMount}/Media/Downloads"
    "${vars.nasMount}/Media/TV"
    "${vars.nasMount}/Media/Movies"
    "${vars.nasMount}/Media/Music"
    "${vars.nasMount}/Media/Audiobooks"
    "${vars.nasMount}/Media/Books"
  ];
in
{

  # TODO: 
  # - enable 265 by uncommenting the last 6 lines of the recyclarr configs
  # - enable 2160p profiles

  # Uncomment the six lines for x265 HD in Sonarr config
  # $sed -i "s/# - 47435ece6b99a0b477caf360e79ba0bb/- 47435ece6b99a0b477caf360e79ba0bb/" $tempSonarr
  # $sed -i "s/# assign_scores_to:/assign_scores_to:/" $tempSonarr
  # $sed -i "s/# - name: WEB-1080p/- name: WEB-1080p/" $tempSonarr
  # $sed -i "s/# score: 0/score: 0/" $tempSonarr
  # $sed -i "s/# - trash_ids:/- trash_ids/" $tempSonarr
  # $sed -i "s/# - 9b64dff695c2115facf1b6ea59c9bd07 # x265 (no HDR/DV):/- 9b64dff695c2115facf1b6ea59c9bd07/" $tempSonarr
  #
  # # Uncomment the six lines for x265 HD in Radarr config
  # $sed -i "s/# - dc98083864ea246d05a42df0d05f81cc/- dc98083864ea246d05a42df0d05f81cc/" $tempRadarr
  # $sed -i "s/# assign_scores_to:/assign_scores_to:/" $tempRadarr
  # $sed -i "s/# - name: Remux + WEB 1080p/- name: Remux + WEB 1080p/" $tempRadarr
  # $sed -i "s/# score: 0/score: 0/" $tempRadarr
  # $sed -i "s/# - trash_ids:/- trash_ids/" $tempRadarr
  # $sed -i "s/# - 839bea857ed2c0a8e084f3cbdbd65ecb # x265 (no HDR/DV):/- 839bea857ed2c0a8e084f3cbdbd65ecb/" $tempRadarr

  system.activationScripts.recyclarr_configure = ''
    sed=${pkgs.gnused}/bin/sed
    configFile=${vars.serviceConfigRoot}/recyclarr/recyclarr.yml

    # Copy the templates to a temporary writable location
    tempSonarr=$(mktemp)
    tempRadarr=$(mktemp)
    cp "${inputs.recyclarr-configs}/sonarr/templates/web-2160p-v4.yml" $tempSonarr
    cp "${inputs.recyclarr-configs}/radarr/templates/remux-web-2160p.yml" $tempRadarr

    sonarrApiKey=$(cat "${config.age.secrets.sonarrApiKey.path}")
    radarrApiKey=$(cat "${config.age.secrets.radarrApiKey.path}")

    # Remove the specified line from the Sonarr template
    $sed -i "/- template: sonarr-quality-definition-series/d" $tempSonarr

    # Remove the specified line from the Radarr template
    $sed -i "/- template: radarr-quality-definition-movie/d" $tempRadarr

    cat $tempSonarr > $configFile
    $sed -i "s/Put your API key here/$sonarrApiKey/g" $configFile
    $sed -i "s/Put your Sonarr URL here/http:\/\/127.0.0.1:8989/g" $configFile

    printf "\n" >> $configFile
    cat $tempRadarr >> $configFile
    $sed -i "s/Put your API key here/$radarrApiKey/g" $configFile
    $sed -i "s/Put your Radarr URL here/http:\/\/127.0.0.1:7878/g" $configFile

    # Clean up temporary files
    rm $tempSonarr $tempRadarr
  '';


  # TODO: move cockpit elsewhere
  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };

  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;

  virtualisation.oci-containers = {
    containers = {
      portainer = {
        image = "portainer/portainer-ce";
        autoStart = true;
        ports = [ "9000:9000" ];
        volumes = [
          "${vars.serviceConfigRoot}/portainer:/data"
          "/run/podman/podman.sock:/var/run/docker.sock"
        ];
      };

      gluetun = {
        image = "qmcgaw/gluetun";
        autoStart = true;
        extraOptions = [
          "--cap-add=NET_ADMIN"
          "--device=/dev/net/tun:/dev/net/tun"
        ];
        ports = [
          "6881:6881"
          "6881:6881/udp"
          "6767:6767" # bazarr
          "8080:8080" # qbittorrent
          "9696:9696" # Prowlarr
          "8989:8989" # Sonarr
          "7878:7878" # Radarr
        ];
        environmentFiles = [
          config.age.secrets.protonvpnCredentials.path
        ];
        environment = {
          VPN_SERVICE_PROVIDER = "protonvpn";
        };
      };

      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent";
        autoStart = true;
        dependsOn = [ "gluetun" ];
        extraOptions = [ "--network=container:gluetun" ];
        environment = {
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          TZ = vars.timeZone;
          WEBUI_PORT = "8080";
        };
        # TODO: sort out proper directory structure and permissions
        volumes = [
          "${vars.serviceConfigRoot}/qbittorrent:/config"
          "${vars.nasMount}/Media/Downloads:/data/torrents"
          "${vars.nasMount}/Media/Downloads:/downloads"
        ];
      };

      sonarr = {
        image = "lscr.io/linuxserver/sonarr:develop";
        autoStart = true;
        dependsOn = [ "gluetun" ];
        extraOptions = [ "--network=container:gluetun" ];
        volumes = [
          "${vars.nasMount}/Media/Downloads:/downloads"
          "${vars.nasMount}/Media/TV:/tv"
          "${vars.serviceConfigRoot}/sonarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          # TODO: implement this way of configuring the PUID and PGID
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          UMASK = "002";
        };
      };

      prowlarr = {
        image = "binhex/arch-prowlarr";
        autoStart = true;
        dependsOn = [ "gluetun" ];
        extraOptions = [
          "--network=container:gluetun"
          "--pull=always"
        ];
        volumes = [
          "${vars.serviceConfigRoot}/prowlarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          UMASK = "002";
        };
      };

      radarr = {
        image = "lscr.io/linuxserver/radarr";
        autoStart = true;
        dependsOn = [ "gluetun" ];
        extraOptions = [
          "--network=container:gluetun"
          "--pull=always"
        ];
        volumes = [
          "${vars.nasMount}/Media/Downloads:/downloads"
          "${vars.nasMount}/Media/Movies:/movies"
          "${vars.serviceConfigRoot}/radarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          UMASK = "002";
        };
      };

      bazarr = {
        image = "ghcr.io/linuxserver/bazarr";
        extraOptions = [ "--network=container:gluetun" ];
        volumes = [
          "${vars.serviceConfigRoot}/bazarr:/config"
          "${vars.nasMount}/Media/Movies:/movies"
          "${vars.nasMount}/Media/TV:/tv"
        ];
        # extraOptions = [ "--network=host" ];
        environment = {
          TZ = vars.timeZone;
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
        };
      };

      jellyfin = {
        image = "jellyfin/jellyfin:10.10.6";
        autoStart = true;
        volumes = [
          # TODO: redo nas directory structure according to trash guides
          "${vars.nasMount}/Media:/Media"
          "${vars.serviceConfigRoot}/jellyfin/config:/config"
          "${vars.serviceConfigRoot}/jellyfin/cache:/cache"
        ];
        user = "${toString config.users.users.share.uid}:${toString config.users.groups.share.gid}";
        environment = {
          TZ = vars.timeZone;
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          # UMASK = "002";
        };
        ports = [
          "8096:8096"
          "8920:8920"
          "7359:7359/udp"
          "1900:1900/udp"
        ];
        #devices: uncomment these and amend if you require GPU accelerated transcoding
        #  - /dev/dri/renderD128:/dev/dri/renderD128
        #  - /dev/dri/card0:/dev/dri/card0
        #
        #
      };

      jellyseerr = {
        autoStart = true;
        image = "fallenbagel/jellyseerr:2.5.1";
        volumes = [ "${vars.serviceConfigRoot}/jellyseerr:/app/config" ];
        ports = [ "5055:5055" ];
        environment = {
          TZ = vars.timeZone;
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
        };
      };

      # check out this confuration of recyclarr https://github.com/TastyPi/nixos/blob/6572c7a7461373351047b6e59457d5a9bb9f87e7/nixos/server/oci-containers/recyclarr.nix
      recyclarr = {
        image = "ghcr.io/recyclarr/recyclarr";
        user = "${toString config.users.users.share.uid}:${toString config.users.groups.share.gid}";
        extraOptions = [ "--network=container:gluetun" ];
        autoStart = true;
        volumes = [
          "${vars.serviceConfigRoot}/recyclarr:/config"
        ];
        environment = {
          CRON_SCHEDULE = "@daily";
          # CRON_SCHEDULE = "* * * * *";
        };
      };
    };
  };
}



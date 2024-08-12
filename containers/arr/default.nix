{ inputs, lib, config, pkgs, vars, ... }:
let
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
    "${vars.serviceConfigRoot}/booksonic"
    "${vars.nasMount}/Media/Downloads"
    "${vars.nasMount}/Media/TV"
    "${vars.nasMount}/Media/Movies"
    "${vars.nasMount}/Media/Music"
    "${vars.nasMount}/Media/Audiobooks"
    "${vars.nasMount}/Media/Books"
    # "${vars.nasMount}/torrents"
  ];
in
{

  # TODO: setup recylarr 
  #
  # system.activationScripts.recyclarr_configure = ''
  #   sed=${pkgs.gnused}/bin/sed
  #   configFile=${vars.serviceConfigRoot}/recyclarr/recyclarr.yml
  #   sonarr="${inputs.recyclarr-configs}/sonarr/templates/web-2160p-v4.yml"
  #   sonarrApiKey=$(cat "${config.age.secrets.sonarrApiKey.path}")
  #   radarr="${inputs.recyclarr-configs}/radarr/templates/remux-web-2160p.yml"
  #   radarrApiKey=$(cat "${config.age.secrets.radarrApiKey.path}")
  #
  #   cat $sonarr > $configFile
  #   $sed -i"" "s/Put your API key here/$sonarrApiKey/g" $configFile
  #   $sed -i"" "s/Put your Sonarr URL here/https:\/\/sonarr.${vars.domainName}/g" $configFile
  #
  #   printf "\n" >> ${vars.serviceConfigRoot}/recyclarr/recyclarr.yml
  #   cat $radarr >> ${vars.serviceConfigRoot}/recyclarr/recyclarr.yml
  #   $sed -i"" "s/Put your API key here/$radarrApiKey/g" $configFile
  #   $sed -i"" "s/Put your Radarr URL here/https:\/\/radarr.${vars.domainName}/g" $configFile
  #
  # '';

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
          "${vars.nasMount}/torrents:/data/torrents"
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
        extraOptions = [ "--network=container:gluetun" ];
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
        extraOptions = [ "--network=container:gluetun" ];
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

      jellyfin = {
        image = "jellyfin/jellyfin";
        autoStart = true;
        # extraOptions = [ "--network=container:gluetun" ];
        volumes = [
          # TODO: redo nas directory structure according to trash guides
          "${vars.nasMount}/Media/Books:/Books:ro"
          "${vars.nasMount}/Media/Music:/Music:ro"
          "${vars.nasMount}/Media/Shows:/Shows:ro"
          "${vars.nasMount}/Media/Movies:/Movies:ro"
          "${vars.serviceConfigRoot}/jellyfin/config:/config"
          "${vars.serviceConfigRoot}/jellyfin/cache:/cache"
        ];
        user = "${toString config.users.users.share.uid}:${toString config.users.groups.share.gid}";
        environment = {
          TZ = vars.timeZone;
          # PUID = "${toString config.users.users.share.uid}";
          # PGID = "${toString config.users.groups.share.gid}";
          UMASK = "002";
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
      };


      # jellyfin:
      #   image: jellyfin/jellyfin
      #   container_name: jellyfin
      #   user: ${PUID}:${PGID}
      #   #group_add:
      #   #  - '109'  # This needs to be the group id of running `stat -c '%g' /dev/dri/renderD128` on the docker host
      #   environment:
      #     - TZ=Europe/London
      #   volumes:
      #     - /home/arar/docker/appdata/jellyfin/config:/config
      #     - /home/arar/docker/appdata/jellyfin/cache:/cache
      #     - /home/arar/nas/server/data/media/movies:/Movies:ro
      #     - /home/arar/nas/server/data/media/shows:/Shows:ro
      #     - /home/arar/nas/server/data/books/:/Books:ro
      #     - /home/arar/nas/server/data/music:/Music:ro
      #   ports:
      #     - 8096:8096
      #     - 8920:8920 #optional
      #     - 7359:7359/udp #optional
      #     - 1900:1900/udp #optional
      #   #devices: uncomment these and amend if you require GPU accelerated transcoding
      #   #  - /dev/dri/renderD128:/dev/dri/renderD128
      #   #  - /dev/dri/card0:/dev/dri/card0






      #      booksonic = {
      #        image = "lscr.io/linuxserver/booksonic-air";
      #        autoStart = true;
      #        extraOptions = [ ];
      #        volumes = [
      #          "${vars.nasMount}/Media/Audiobooks:/audiobooks"
      #          "${vars.serviceConfigRoot}/booksonic:/config"
      #        ];
      #        environment = {
      #          TZ = vars.timeZone;
      #          PUID = "994";
      #          GUID = "993";
      #          CONTEXT_PATH = "/";
      #          UMASK = "002";
      #        };
      #      };
      # recyclarr = {
      #   image = "ghcr.io/recyclarr/recyclarr";
      #   user = "994:993";
      #   autoStart = true;
      #   volumes = [
      #     "${vars.serviceConfigRoot}/recyclarr:/config"
      #   ];
      #   environment = {
      #     CRON_SCHEDULE = "@daily";
      #   };
      # };
    };
  };
}



{ inputs, lib, config, pkgs, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/sonarr"
    "${vars.serviceConfigRoot}/radarr"
    "${vars.serviceConfigRoot}/prowlarr"
    "${vars.serviceConfigRoot}/recyclarr"
    "${vars.serviceConfigRoot}/booksonic"
    "${vars.nasMount}/Media/Downloads"
    "${vars.nasMount}/Media/TV"
    "${vars.nasMount}/Media/Movies"
    "${vars.nasMount}/Media/Audiobooks"
  ];
in
{

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

  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      sonarr = {
        image = "lscr.io/linuxserver/sonarr:develop";
        autoStart = true;
        extraOptions = [
        ];
		ports = [
		"8989:8989"
		];
        volumes = [
          "${vars.nasMount}/Media/Downloads:/downloads"
          "${vars.nasMount}/Media/TV:/tv"
          "${vars.serviceConfigRoot}/sonarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "994";
          GUID = "993";
          UMASK = "002";
        };
      };
      prowlarr = {
        image = "binhex/arch-prowlarr";
        autoStart = true;
        extraOptions = [ ];
		ports = [
		"9696:9696"
		];
        volumes = [
          "${vars.serviceConfigRoot}/prowlarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "994";
          GUID = "993";
          UMASK = "002";
        };
      };
      radarr = {
        image = "lscr.io/linuxserver/radarr";
        autoStart = true;
        extraOptions = [ ];
		ports = [
		"7878:7878"
		];
        volumes = [
          "${vars.nasMount}/Media/Downloads:/downloads"
          "${vars.nasMount}/Media/Movies:/movies"
          "${vars.serviceConfigRoot}/radarr:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "994";
          GUID = "993";
          UMASK = "002";
        };
      };
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


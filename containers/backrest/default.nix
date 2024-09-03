{ config, vars, ... }:

let
  directories = [
    "${vars.serviceConfigRoot}/backrest"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;

  virtualisation.oci-containers = {
    containers = {
      backrest = {
        image = "garethgeorge/backrest:latest";
        autoStart = true;
        ports = [ "9898:9898" ];
        volumes = [
          "${vars.serviceConfigRoot}/backrest:/config"
          "${vars.nasMount}/Backups/restic:/data"
          # Uncomment and adjust these as needed
          # "${server.data}/backrest:/data"
          # "${server.cache}/backrest:/cache"
          # "${server.data}:/userdata"
        ];
        environment = {
          BACKREST_CONFIG = "/config/config.json";
          BACKREST_DATA = "/data";
          XDG_CACHE_HOME = "/cache";
        };
      };
    };
  };
}



#   virtualisation.oci-containers = {
#     containers = {
#       backrest = {
#           image = "garethgeorge/backrest";
#           container_name = "backrest";
#           autoStart = true;
#           ports = [ "9898:9898" ];
#           volumes = [
#             "${vars.serviceConfigRoot}/backrest:/config"
#             "${vars.nasMount}/Backups/restic:data"
#             # Uncomment and adjust these as needed
#             # "${server.data}/backrest:/data"
#             # "${server.cache}/backrest:/cache"
#             # "${server.data}:/userdata"
#           ];
#           environment = {
#             BACKREST_CONFIG = "/config/config.json";
#             BACKREST_DATA = "/data";
#             XDG_CACHE_HOME = "/cache";
#           };
#       };
#     };
#   };
# }
#

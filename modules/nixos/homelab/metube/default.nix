{ config, vars, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      metube = {
        image = "ghcr.io/alexta69/metube";
        autoStart = true;
        ports = [ "8082:8081" ];
        volumes = [
          "${vars.homelabNasMount}/Media/Youtube:/downloads"
        ];
        environment =
          {
            UID = "${toString config.users.users.share.uid}";
            GID = "${toString config.users.groups.share.gid}";
            DEFAULT_THEME = "dark";
          };
      };
    };
  };
}



{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/mealie"
  ];
in
# TODO: setup creation of automatic backups
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      mealie = {
        image = "ghcr.io/mealie-recipes/mealie:v1.7.0";
        autoStart = true;
        ports = [ "9925:9000" ];
        extraOptions = [ ];
        volumes = [ "${vars.serviceConfigRoot}/mealie:/data" ];
        environment =
          {
            PUID = "${toString config.users.users.share.uid}";
            PGID = "${toString config.users.groups.share.gid}";
            TZ = vars.timeZone;
            ALLOW_SIGNUP = "true";
          };
      };
    };
  };
}

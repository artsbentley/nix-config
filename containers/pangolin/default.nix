{ config, vars, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      pangolin = {
        image = "fosrl/newt";
        autoStart = true;
        extraOptions = [ ];
        environmentFiles = [
          config.age.secrets.pangolin.path
        ];
        # environment =
        #   {
        #     PUID = "${toString config.users.users.share.uid}";
        #     PGID = "${toString config.users.groups.share.gid}";
        #     TZ = vars.timeZone;
        #   };
      };
    };
  };
}


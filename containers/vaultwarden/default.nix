{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/vaultwarden"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      vaultwarden = {
        image = "vaultwarden/server:latest";
        autoStart = true;
        ports = [ "8081:80" ];
        extraOptions = [ ];
        volumes = [ "${vars.serviceConfigRoot}/vaultwarden:/data" ];
        environmentFiles = [ config.age.secrets.vaultwarden.path ];
        environment = {
          # DOMAIN = "https://pass.${vars.domainName}";
          WEBSOCKET_ENABLED = "true";
        };
      };
    };
    # TODO this needs a cronjob to be run daily
    bw-export = {
      image = "0netx/bw-export";
      # autoStart = true;
      volumes = [
        "${vars.nasMount}/Backup/vaultwarden/arar/data:/var/attachment"
        "${vars.nasMount}/Backup/vaultwarden/arar/attachment:/var/attachment"
      ];
      # NOTE: this .env might collide with vaultwarden, if it does, seperate out into
      # its own env file
      environmentFiles = [ config.age.secrets.vaultwarden.path ];
      environment = {
        PUID = "${toString config.users.users.share.uid}";
        PGID = "${toString config.users.groups.share.gid}";
        KEEP_LAST_BACKUPS = 50;
      };
    };
  };
}


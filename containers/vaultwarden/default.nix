{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/vaultwarden"
    "${vars.nasMount}/Backups/vaultwarden/arar/data"
    "${vars.nasMount}/Backups/vaultwarden/arar/attachment"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      vaultwarden = {
        image = "vaultwarden/server:1.32.4";
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
      bitwarden-portal = {
        image = "reaper0x1/bitwarden-portal:1.0.1";
        autoStart = true;
        extraOptions = [ ];
        volumes = [ "${vars.serviceConfigRoot}/vaultwarden:/data" ];
        environmentFiles = [ config.age.secrets.vaultwarden.path ];
        environment = {
          PUID = "${toString config.users.users.share.uid}";
          PGID = "${toString config.users.groups.share.gid}";
          KEEP_LAST_BACKUPS = "50";
          ENABLE_PRUNING = "true";
          RETENTION_DAYS = 50;
          MIN_FILES = 30;
          CRON_SCHEDULE = "0 0 * * *";
          TZ = "Europe/Berlin";
        };
      };



      # BUG: 
      # bw --apikey login is currently bugged: https://github.com/bitwarden/clients/issues/9953
      # bw-backup = {
      #   image = "0netx/bw-export";
      #   autoStart = true;
      #   volumes = [
      #     "${vars.nasMount}/Backups/vaultwarden/arar/data:/var/data"
      #     "${vars.nasMount}/Backups/vaultwarden/arar/attachment:/var/attachment"
      #   ];
      #   environmentFiles = [ config.age.secrets.vaultwarden.path ];
      #   environment = {
      #     PUID = "${toString config.users.users.share.uid}";
      #     PGID = "${toString config.users.groups.share.gid}";
      #     KEEP_LAST_BACKUPS = "50";
      #   };
      # };
    };

  };
  # TODO this needs a cronjob to be run daily
}


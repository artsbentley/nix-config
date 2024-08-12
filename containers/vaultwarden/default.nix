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
        environmentFiles = [
          config.age.secrets.vaultwarden.path
        ];
        environment = {
          # DOMAIN = "https://pass.${vars.domainName}";
          WEBSOCKET_ENABLED = "true";
        };
      };
    };
  };
}


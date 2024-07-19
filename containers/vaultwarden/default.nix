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
        extraOptions = [ ];
        volumes = [
          "${vars.serviceConfigRoot}/vaultwarden:/data"
        ];
        environment = {
          DOMAIN = "https://pass.${vars.domainName}";
          WEBSOCKET_ENABLED = "true";
        };
      };
    };
  };
}

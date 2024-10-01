{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/actualbudget"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      actualbudget = {
        image = "actualbudget/actual-server:latest";
        autoStart = true;
        ports = [ "5006:5006" ];
        extraOptions = [ ];
        environment = { };
        volumes = [ "${vars.serviceConfigRoot}/actualbudget:/data" ];
        environmentFiles = [ config.age.secrets.vaultwarden.path ];
      };
    };
  };
}


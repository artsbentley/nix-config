{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/enclosed"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      enclosed = {
        image = "corentinth/enclosed";
        autoStart = true;
        ports = [ "8787:8787" ];
        volumes = [ "${vars.serviceConfigRoot}/enclosed:/app/.data" ];
        environment =
          {
            NOTES_MAX_ENCRYPTED_PAYLOAD_LENGTH = "21474836480";
          };
      };
    };
  };
}



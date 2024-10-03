{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/sterling"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      stirling = {
        image = "frooodle/s-pdf:latest";
        autoStart = true;
        ports = [ "8082:8080" ];
        extraOptions = [ ];
        volumes = [ "${vars.serviceConfigRoot}/stirling:/configs" ];
        environment = {
          LANGS = "en_GB";
          DOCKER_ENABLE_SECURITY = "false";
          INSTALL_BOOK_AND_ADVANCED_HTML_OPS = "false";
        };
      };
    };
  };
}


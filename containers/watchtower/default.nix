{ config, pkgs, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/watchtower"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers.containers."watchtower" = {
    autoStart = true;
    image = "containrrr/watchtower";
    volumes = [
      "${vars.serviceConfigRoot}/watchtower:/data"
      # "/var/run/docker.sock:/var/run/docker.sock"
      "/run/podman/podman.sock:/var/run/docker.sock"
    ];
  };

}

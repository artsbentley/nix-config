{ config, pkgs, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/uptimekuma"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers.containers."uptimekuma" = {
    autoStart = true;
    image = "louislam/uptime-kuma";
    environment = { };
    volumes = [
      "${vars.serviceConfigRoot}/uptimekuma:/app/data"
      "/run/podman/podman.sock:/var/run/docker.sock"
    ];
    ports = [
      "3001:3001"
    ];
  };

}

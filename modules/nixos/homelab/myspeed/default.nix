{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/myspeed"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      myspeed = {
        image = "germannewsmaker/myspeed";
        pull = "newer";
        volumes = [ "${vars.serviceConfigRoot}/myspeed:/myspeed/data" ];
        ports = [ "5216:5216" ];
        environment = { };
      };
    };
  };
}










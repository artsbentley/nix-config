{ config, vars, ... }:
let directories = [
  "${vars.serviceConfigRoot}/deluge"
  "${vars.serviceConfigRoot}/radarr"
  "${vars.serviceConfigRoot}/prowlarr"
  "${vars.serviceConfigRoot}/recyclarr"
  "${vars.nasMount}/Media/Downloads"
];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      deluge = {
        image = "linuxserver/deluge:latest";
        autoStart = true;
        dependsOn = [
          "gluetun"
        ];
        extraOptions = [
          "--network=container:gluetun"
        ];
        volumes = [
          "${vars.nasMount}/Media/Downloads:/data/completed"
          "${vars.serviceConfigRoot}/deluge:/config"
        ];
        environment = {
          TZ = vars.timeZone;
          PUID = "994";
          GUID = "993";
        };
      };
      gluetun = {
        image = "qmcgaw/gluetun:latest";
        autoStart = true;
        extraOptions = [
          "--cap-add=NET_ADMIN"
          "--device=/dev/net/tun:/dev/net/tun"
        ];
        ports = [
          "127.0.0.1:8083:8000"
        ];
        environmentFiles = [
          config.age.secrets.protonvpnCredentials.path
        ];
        environment = {
          VPN_SERVICE_PROVIDER = "protonvpn";
        };
      };
    };
  };
}

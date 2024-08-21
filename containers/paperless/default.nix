{ config, vars, ... }:
let
  # TODO: decide if this receives the same mount/ nas var as arr stack, downside
  # if they have the same is that they are strongly tied together and it will
  # become difficult to seperate them or refactor the directory location
  directories = [
    "${vars.serviceConfigRoot}/paperless"
    "${vars.nasMount}/Documents"
    "${vars.nasMount}/Documents/Paperless"
    "${vars.nasMount}/Documents/Paperless/Documents"
    "${vars.nasMount}/Documents/Paperless/Import"
    "${vars.nasMount}/Documents/Paperless/Export"
  ];
in
{

  systemd.services = {
    podman-paperless-redis = {
      requires = [ "podman-paperless.service" ];
      after = [ "podman-paperless.service" ];
    };
  };
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;

  # TODO: enable webdav
  # networking.firewall.allowedTCPPorts = [
  #   8088 # WebDAV
  # ];
  #
  # services.webdav = {
  #   enable = true;
  #   user = "share";
  #   group = "share";
  #   environmentFile = config.age.secrets.paperless.path;
  #   settings = {
  #     address = "0.0.0.0";
  #     port = 8088;
  #     scope = "${vars.nasMount}/Documents/Paperless/Import";
  #     modify = true;
  #     auth = true;
  #     users = [
  #       {
  #         username = "arar";
  #         password = "{env}PASSWORD";
  #       }
  #     ];
  #   };
  # };

  virtualisation.oci-containers = {
    containers = {
      # TODO: add gotenberg and tika
      paperless = {
        image = "ghcr.io/paperless-ngx/paperless-ngx";
        autoStart = true;
        ports = [ "8000:8000" ];
        extraOptions = [
          "--device=/dev/dri:/dev/dri"
        ];
        volumes = [
          "${vars.nasMount}/Documents/Paperless/Documents:/usr/src/paperless/media"
          "${vars.nasMount}/Documents/Paperless/Import:/usr/src/paperless/consume"
          "${vars.nasMount}/Documents/Paperless/Export:/usr/src/paperless/export"
          "${vars.serviceConfigRoot}/paperless:/usr/src/paperless/data"
        ];
        environmentFiles = [
          config.age.secrets.paperless.path
        ];
        environment = {
          PAPERLESS_REDIS = "redis://paperless-redis:6379";
          PAPERLESS_OCR_LANGUAGE = "eng";
          PAPERLESS_OCR_LANGUAGES = "nld";
          PAPERLESS_FILENAME_FORMAT = "{created}/{correspondent}/{title}";
          PAPERLESS_TIME_ZONE = "${vars.timeZone}";
          PAPERLESS_CONSUMER_POLLING = "1";
          PAPERLESS_TIKA_ENABLED = "1";
          PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://gotenberg:3000";
          PAPERLESS_TIKA_ENDPOINT = "http://tika:9998";

          USERMAP_UID = "${toString config.users.users.share.uid}";
          USERMAP_GID = "${toString config.users.groups.share.gid}";
        };
      };
      paperless-redis = {
        image = "docker.io/library/redis:7";
        autoStart = true;
      };

      gotenberg = {
        image = "docker.io/gotenberg/gotenberg:7.10";
        autoStart = true;
        cmd = [ "gotenberg" "--chromium-disable-javascript=true" "--chromium-allow-list=file:///tmp/.*" ];
      };

      tika = {
        image = "ghcr.io/paperless-ngx/tika:latest";
        autoStart = true;
      };
    };
  };
}



{ config, vars, ... }:

let
  directories = [
    "${vars.serviceConfigRoot}/gitea"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers.containers."gitea" = {
    autoStart = true;
    image = "gitea/gitea:latest";
    environment = {
      USER_UID = "${toString config.users.users.share.uid}";
      USER_GID = "${toString config.users.groups.share.gid}";
	  USER = "share";
	  DISABLE_REGISTRATION = "true";
    };
    volumes = [
      "${vars.serviceConfigRoot}/gitea:/data"
      "/etc/timezone:/etc/timezone:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    ports = [
      "3010:3000"
      "222:22"
    ];
  };
}


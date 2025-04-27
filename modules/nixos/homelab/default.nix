{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}: {
  # shared user that has access to all homelab services
  users = {
    groups.share = {
      gid = 1010;
    };
    users.share = {
      uid = 1010;
      isSystemUser = true;
      group = "share";
    };
  };
  users.users.${userConfig.name}.extraGroups = [ "share" ];
}


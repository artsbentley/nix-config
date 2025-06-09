{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}: {
  imports = [
    ./podman.nix
    # TODO: sanz instead of torrent
    ./arr
    ./paperless
    ./mealie
    ./vaultwarden
    ./homepage
    ./pangolin
    ./enclosed
    ./uptimekuma
    ./cv
    ./blog
    ./miniflux
    ./metube
    ./karakeep
    ./myspeed
    # ./gitea
    # ./actualbudget
    # ./stirling
    # ./watchtower
    # ./backrest
  ];

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


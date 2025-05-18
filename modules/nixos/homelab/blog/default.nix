{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}:
# TODO:
# - fetchgithub for blog
# - symlink from notes directory
let
  # hugoSiteDir = "/home/arar/my-hugo-site";  # ← point this at your Hugo project
  hugoSiteDir = ./blog;
  hugoUser = userConfig.name;
  hugoGroup = userConfig.name;
in
{
  environment.systemPackages = with pkgs; [
    hugo
    go
  ];

  systemd.services.blog = {
    description = "Hugo Static-Site Server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      # run on localhost only, port 1313, draft content enabled
      ExecStart = "${pkgs.hugo}/bin/hugo server \
                       --bind=0.0.0.0 \
                       --port=1313 \
                       --source=${hugoSiteDir} \
                       --watch";
      WorkingDirectory = hugoSiteDir;
      Restart = "always";
      # User = hugoUser;
      # Group = hugoGroup;
    };
  };
}

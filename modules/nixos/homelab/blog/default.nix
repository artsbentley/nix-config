{ inputs
, outputs
, lib
, config
, userConfig
, hostConfig
, pkgs
, ...
}:
let
  # hugoSiteDir = "/home/arar/my-hugo-site";  # ← point this at your Hugo project
  hugoSiteDir = ./hugo-blog;
  hugoUser = userConfig.Name;
  hugoGroup = userConfig.Name;
in
{
  environment.systemPackages = with pkgs; [
    hugo
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
      User = hugoUser;
      Group = hugoGroup;
    };
  };
}

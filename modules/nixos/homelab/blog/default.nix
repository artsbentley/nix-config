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
  hugoSiteDir = ./blog;
  hugoUser = userConfig.name;
  hugoGroup = userConfig.name;

  blogStatic = pkgs.stdenv.mkDerivation {
    pname = "blog-static";
    src = hugoSiteDir;
    nativeBuildInputs = [ pkgs.hugo ];

    installPhase = ''
      mkdir -p $out
      cp -r ./public/* $out/
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    hugo
    go
    blogStatic
  ];

  systemd.services.blog = {
    description = "Hugo Static-Site Server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.go ];
    serviceConfig = {
      ExecStart = ''
        ${blogStatic}/bin/hugo server \
          --bind=0.0.0.0 \
          --port=1313 \
          --source=${hugoSiteDir} \
          --watch
      '';

      WorkingDirectory = hugoSiteDir;
      Restart = "always";
      # User = hugoUser;
      # Group = hugoGroup;
    };
  };
}


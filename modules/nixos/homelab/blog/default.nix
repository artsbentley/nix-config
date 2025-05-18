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
    version = "0.1";
    src = hugoSiteDir;
    nativeBuildInputs = [ pkgs.hugo ];
    buildPhase = ''
      hugo -s "$src" -d "$out"
    '';
    installPhase = "true"; # nothing to install, everything already in $out
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
        ${pkgs.hugo}/bin/hugo server \
          --bind=0.0.0.0 \
          --port=1313 \
          --source=${blogStatic} \
          --watch
      '';
      WorkingDirectory = hugoSiteDir;
      Restart = "always";
      # User = hugoUser;
      # Group = hugoGroup;
    };
  };
}


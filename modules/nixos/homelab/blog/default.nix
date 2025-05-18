{ pkgs, ... }:

let
  siteDir = /home/arar/nix-config/modules/nixos/homelab/blog/blog;
  publicDir = "${siteDir}/public";
in
{
  systemd.services.zola-build = {
    description = "Zola static site build";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = siteDir;
      ExecStart = "${pkgs.zola}/bin/zola build";
    };
  };

  systemd.services.zola-server = {
    description = "Serve built Zola site with miniserve";
    after = [ "zola-build.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.miniserve}/bin/miniserve ${publicDir} --index index.html --port 1111 --interfaces 0.0.0.0";
      Restart = "always";
    };
  };

  networking.firewall.allowedTCPPorts = [ 1111 ];
  environment.systemPackages = with pkgs; [ zola miniserve ];
}


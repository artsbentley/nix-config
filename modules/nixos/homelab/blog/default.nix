{ pkgs, ... }:

let
  siteDir = "/home/arar/nix-config/modules/nixos/homelab/blog/blog";
  publicDir = "${siteDir}/public";
in
{
  # systemd.services.zola-build = {
  #   description = "Zola static site build";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     WorkingDirectory = siteDir;
  #     ExecStart = "${pkgs.zola}/bin/zola build";
  #   };
  # };

  systemd.services.zola-server = {
    description = "Serve Zola site with miniserve";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.zola}/bin/zola build";
      ExecStart = "${pkgs.miniserve}/bin/miniserve ${publicDir} --index index.html --port 1111 --interfaces 0.0.0.0";
      Restart = "always";
      Type = "oneshot";
      WorkingDirectory = siteDir;
    };
    path = [ pkgs.nix ];
    startAt = "*:0/5";
  };

  networking.firewall.allowedTCPPorts = [ 1111 ];
  environment.systemPackages = with pkgs; [ zola miniserve ];
}


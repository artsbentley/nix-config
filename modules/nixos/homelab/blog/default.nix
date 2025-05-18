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
    pathConfig = {
      PathModified = siteDir;
    };
    serviceConfig = {
      ExecStartPre = "${pkgs.zola}/bin/zola build";
      ExecStart = "${pkgs.miniserve}/bin/miniserve ${publicDir} --index index.html --port 1111 --interfaces 0.0.0.0";
      Restart = "always";
      WorkingDirectory = siteDir;
    };
  };

  # system.activationScripts.zola-site = ''
  #   echo -e "\e[32mRunning Zola build and restarting server...\e[0m"
  #   systemctl restart zola-server.service
  # '';

  networking.firewall.allowedTCPPorts = [ 1111 ];
  environment.systemPackages = with pkgs; [ zola miniserve ];
}


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
      Restart = "always"; # Keep restart=always for general service robustness
      WorkingDirectory = siteDir;
    };
  };

  # Define a systemd service that will restart the zola-server
  systemd.services.zola-restart-on-change = {
    description = "Restart Zola server after site changes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart zola-server.service";
      User = "root"; # Or the user your zola-server runs as
    };
    # This service is triggered by the path unit, not by a target
    # wantedBy = [ "multi-user.target" ];
  };

  # Define the systemd path unit to watch the siteDir
  systemd.paths.zola-site-watch = {
    description = "Watch Zola site directory for changes";
    pathConfig = {
      PathChanged = siteDir;
      Unit = "zola-restart-on-change.service"; # The service to activate
    };
    wantedBy = [ "multi-user.target" ]; # Start watching when the system is ready
  };

  # system.activationScripts.zola-site = ''
  #   echo -e "\e[32mRunning Zola build and restarting server...\e[0m"
  #   systemctl restart zola-server.service
  # '';

  networking.firewall.allowedTCPPorts = [ 1111 ];
  environment.systemPackages = with pkgs; [ zola miniserve systemd ]; # Ensure systemd is available for systemctl
}

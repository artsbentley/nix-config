{ pkgs, ... }:

let
  siteDir = "/home/arar/nix-config/modules/nixos/homelab/blog/blog";
  publicDir = "${siteDir}/public";
in
{
  systemd.services.zola-server = {
    description = "Serve Zola site with miniserve";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.zola}/bin/zola build";
      ExecStart = "${pkgs.miniserve}/bin/miniserve ${publicDir} --index index.html --port 1111 --interfaces 0.0.0.0";
      Restart = "always";
      WorkingDirectory = siteDir;
    };
  };

  # needed for rebuilding our Zola site on nix rebuild, otherwise systemd won't
  # recognize that there is a change in the system and the site will stay the
  # same
  system.activationScripts.zolaRebuild = {
    text = ''
      echo -e "\e[32mRebuilding Zola site and restarting server...\e[0m"
      ${pkgs.systemd}/bin/systemctl try-restart zola-server.service || true
    '';
    deps = [ "users" "groups" ];
  };

  networking.firewall.allowedTCPPorts = [ 1111 ];
  environment.systemPackages = with pkgs; [ zola miniserve ];
}

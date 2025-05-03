{ inputs, lib, config, pkgs, vars, ... }:

{
  systemd.services.my-go-server = {
    description = "My Go HTTP Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      # WorkingDirectory = "/etc/nixos";
      ExecStart = "/bin/sh -c '/home/arar/nix-config/modules/nixos/homelab/cv/app/main'";
      Restart = "always";
    };
  };
}







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
  blogSiteDir = ./blog;
in
{
  environment.systemPackages = with pkgs; [ zola ];
  systemd.services.zola = {
    description = "zola";
    serviceConfig = {
      ExecStart = "${pkgs.zola}/bin/zola serve --inerface 0.0.0.0";
      WorkingDirectory = "/home/arar/nix-config/modules/nixos/homelab/blog/blog";
      Restart = "always";
    };
    path = with pkgs; [ zola ];
    confinement.packages = with pkgs; [ zola ];
    wantedBy = [
      "multi-user.target"
    ]; # starts after login, reboot after first time rebuild
  };
}

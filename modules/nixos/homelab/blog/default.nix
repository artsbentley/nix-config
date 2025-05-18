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
    serviceConfig.ExecStart = ''
      zola serve
    '';
    serviceConfig.WorkingDirectory = "/home/arar/nix-config/homelab/blog/blog";
    path = with pkgs; [ zola ];
    confinement.packages = with pkgs; [ zola ];
    wantedBy = [
      "multi-user.target"
    ]; # starts after login, reboot after first time rebuild
    Restart = "always";
  };
}

{ config, pkgs, lib, ... }:
{
  nix.settings.trusted-users = [ "arar" ];

  age.identityPaths = [
    "/home/arar/.ssh/arar"
    "/home/arar/.ssh/id_rsa"
  ];

  # age.secrets.hashedUserPassword = {
  #   file = ../../secrets/hashedUserPassword.age;
  # };



  users = {
    users = {
      arar = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.test.path;
        extraGroups = [ "wheel" "users" "video" "podman" ];
        group = "arar";
        # group = config.age.secrets."test".path;
        # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGUGMUo1dRl9xoDlMxQGb8dNSY+6xiEpbZWAu6FAbWw moe@notthebe.ee" ];
      };
    };
    groups = {
      arar = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;

}


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

  # TODO: setup fish, see mitchellh config
  #   # https://github.com/nix-community/home-manager/pull/2408
  # environment.pathsToLink = [ "/share/fish" ];
  # # Add ~/.local/bin to PATH
  # environment.localBinInPath = true;
  # # Since we're using fish as our shell
  # programs.fish.enable = true;

  users = {
    users = {
      arar = {
        # TODO: use fish
        shell = pkgs.fish;
        uid = 1000;
        isNormalUser = true;
        # hashedPasswordFile = config.age.secrets.test.path;
        extraGroups = [ "networkmanager" "wheel" "lxd" "users" "video" "podman" "share" "docker" ];
        group = "arar";
        # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGUGMUo1dRl9xoDlMxQGb8dNSY+6xiEpbZWAu6FAbWw moe@notthebe.ee" ];
      };
    };
    groups = {
      arar = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = false;
  programs.fish.enable = true;

}


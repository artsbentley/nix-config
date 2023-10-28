{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.hostName = "nixos";
  networking.interfaces = {
    enpls0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.42.0.50";
        prefixLength = 20;
      }];
    };
  };
  networking.defaultGateway = "10.42.0.254";
  networking.nameservers = [ "10.42.0.254" ];
}


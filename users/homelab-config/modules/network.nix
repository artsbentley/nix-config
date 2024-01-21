{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.hostName = "nixos";
  networking.interfaces = {
    enpls0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.2.50";
        prefixLength = 20;
      }];
    };
  };
  networking.defaultGateway = "192.168.2.254";  # Updated gateway address
  networking.nameservers = [ "10.42.0.254" ];
}


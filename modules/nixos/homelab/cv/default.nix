{ inputs, lib, config, pkgs, vars, ... }:

let
  app = pkgs.buildGoModule {
    pname = "my-go-server";
    version = "0.1.0";
    src = ./app;
    vendorHash = null;

    # Add the outputBin attribute to specify the binary name
    outputBin = "my-go-server";

    meta = with pkgs.lib; {
      description = "My Go HTTP Server";
      license = licenses.mit;
    };
  };
in
{
  networking.firewall.allowedTCPPorts = [ 3333 ];

  systemd.services.my-go-server = {
    description = "My Go HTTP Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      # Update the ExecStart path to use the new binary name
      ExecStart = "${app}/bin/my-go-server";
      Restart = "always";
    };
  };
}

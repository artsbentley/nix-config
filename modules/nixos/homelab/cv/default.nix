{ inputs, lib, config, pkgs, vars, ... }:

let
  moduleName = "test";
  app = pkgs.buildGoModule {
    pname = "my-go-server";
    version = "0.1.0";
    src = ./app;
    vendorHash = null;

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
      ExecStart = "${app}/bin/${moduleName}";
      Restart = "always";
    };
  };
}

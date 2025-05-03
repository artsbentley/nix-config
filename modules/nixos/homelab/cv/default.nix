{ inputs, lib, config, pkgs, vars, ... }:

let
  app = pkgs.buildGoModule {
    pname = "my-go-server";
    version = "0.1.0";
    src = ./app;
    vendorHash = null;

    meta = with pkgs.lib; {
      description = "My Go HTTP Server";
      license = licenses.mit;
    };

    # Make sure to set the output directory correctly
    GO_BUILD_FLAGS = [ "-o" "${./result/bin/my-go-server}" ];
  };
in
{
  networking.firewall.allowedTCPPorts = [ 3333 ];

  systemd.services.my-go-server = {
    description = "My Go HTTP Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${app}/result/bin/my-go-server"; # Use the correct path
      Restart = "always";
    };
  };
}


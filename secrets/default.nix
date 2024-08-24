{ modulesPath, lib, config, pkgs, ... }:

{
  age = {
    secrets = {
      test.file = ./test.age;
      protonvpnCredentials.file = ./protonvpnCredentials.age;
      paperless.file = ./paperless.age;
      vaultwarden.file = ./vaultwarden.age;
      smbCredentials.file = ./smbCredentials.age;
      cloudflareTunnel.file = ./cloudflareTunnel.age;
      sonarrApiKey.file = ./sonarrApiKey.age;
      radarrApiKey.file = ./radarrApiKey.age;
      tailscaleAuthKey.file = ./tailscaleAuthKey.age;
      bitwardenSession.file = ./bitwardenSession.age;
    };
  };
}





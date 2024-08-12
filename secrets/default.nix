{ modulesPath, lib, config, pkgs, ... }:

{
  age = {
    secrets = {
      test.file = ./test.age;
      protonvpnCredentials.file = ./protonvpnCredentials.age;
      paperless.file = ./paperless.age;
      vaultwarden.file = ./vaultwarden.age;
    };
  };
}



{ modulesPath, lib, config, pkgs, ... }:

{
  age = {
    secrets = {
      test.file = ./test.age;
      protonvpnCredentials.file = ./protonvpnCredentials.age;
    };
  };
}



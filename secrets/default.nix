{ modulesPath, lib, config, pkgs, ... }:

{
  age = {
    secrets = {
      test.file = ./test.age;
      protonVpnUser = ./protonVpnUser.age;
      protonVpnPass = ./protonVpnPass.age;
    };
  };
}

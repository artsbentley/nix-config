let
  arar-work-mac = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIAhxaP+gOSaWKCv2hzVAEbgq6ONvAlEKHpYZ08c4OO2fw4H48Pil/4ESjameYnCtU8XMljdsNg6r28rXERxsxTcPX7o8ktFzqL8Ey440+5cYGlDwSYOkFACOCptq4NVEqckbOjopyI5vd/yty9Ox7GFJ282pwy/zIqvEsKcwY1EH7ZvHctVH0yarUgpMbGYVrZa1ivVG+/Ss4GlSNbR5bU2GjdwvT+3PvvqRZ4oK1fT0D/7HV8Wm4M2K9XIJV4u5fQ/XXR1DiE/2S/46Nc3eJg9ruuWOOEPi7QItRznOfuXXig70wHVdgbfLHHhQwKcylKLiXW426G3IJ0rqDSqmt6idf6wLAR8ilpcCTr2/36AmIALPbHi9rOeednJySpi6H9Mal73dRThs+mPgWFPk1+B2oDy0tx/VDzAebMwbCZ+MV1LvioJVETcZIQWWBpWpl/FLqB4+ffJItUvjoiQgfokcfXjy1UZJLD/zqUwGspmwvOtBGBC9c8Kj6fFoN+o0= arar@arnos-mbp.home ";
  arar-nixos = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCO+Yva3VbM9bguXo2K5WJnesP14L3bt4Y4XpYYLpaOzUdzUEP7A1AwQkGZrfMv5EG8NjvlQl9sAyrBfj23xDURsoDTY9GUa7eRJ4Cbovt6HV/qxeCcXo0I/ceUrFYRPDTVfkXI/pYauVp7QEcRwNW9KFzVlLzrH2tzOmEPJutDLid4RggSLcjkU3P0O46MPl9/7lcy/1LazqBsVF0vNWF4tVQ6Y0wPbMH2HhDeM+CBIfhdA1sIevWfU5IgJWScaoBzo0Zsf2RqFIjBGDG7UVc6p4fOZolF8Hf2ZKKUFYGQBNY107BPlzjwqrO/6zEZxgzfhnljkhdFv20hEtGaDz8eoarqtA0lb8vZwBYJ7DPa3dMseVtXp8blQ+GFWa8FhI9n4TbUVCyhX5AbtlRmo2iGjtcjfSr+1+rgGjAoeEdp4HuqrjxxCAcusrZvIfP3CCKvtC/vrdbzIuKIzLDSE9LDP+d5szuUvVWZu+yccgfCSpnD3x1B349FHCa16MjcWFFREjYDirHYwEElGDsobMx8u87IxaeFhzrWsozZyOof6B5qvcBTTdfXIQZzMntb1eNUQS+ogdC7r9hfxVgvxLzrp2AuIpBrjXHh9EUqZqOxTEwvUXAnU9kpJMIuclfR9pEyOWJ6z3O7cWRD1Eyvf4FSxU9T4zEm9v2kcHrKBRgTaQ== arar@nixos ";

  root-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDustHrrFS1Fm3SDhtRUGzPxENoVxrlja65xoXc8UtV root@nixos ";
  root2-nixos = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyU1haPhJjwpDdmmVmsyiwX07foB2T0Fe56nr8TX9lczOY9la5TDD1lEg5RUOktBkZXGTor1TVfqabhcApTlGOlauUBA3Es7t0l5syG5mn6SI44kcc7i3tOn2QKgRHzoUP1DUSybCR0CFHcGyD3QR4E5TCUiUSksyWJHp9FCzsTF4mfmAlFEGYdOqAiSWWC4QJWvBFgm8U7ovGyyKFOSzgP8fv3CGiX5WChf16b5G6Tq9PduiGHoL10c56yYzljlFgjoqOEaepTwi0QYAYCT0nrKMlIK9Fo88+ys3dZ3B+RcgSqTYEc62GphAWwv7Zytj9VNjKfuNE9QhSZ2ngMGXELu+0H6uRGOXfMMHOulyL77SKmBrf3GLsUAiQwwQX5532xDvWlIviGqTH3w4VfqMVxdjNXtEjzt8isnpxtgxHtWRsaAkISfqBk097iDUdkAlBP1oHHrCtEQb7go3U2LebY5jB0jObrSjscOnoNlfYOnk/HBmax7V908Q4axLiND7NQI2bVwaMFu9s/YHDBZJaTA8wFyyP23DXQHMX/WI0Dc1VlonM5/786xd3gkOVCfFGe19ns2BdMhmC1MHkCXcEH5uGLJDM3nnV5OXrYjp7iabrRQNQnDhAGTfE9L/fSkeAaAsYJOCNuGYrUw8BopXrp6KzRVfxU3cUB32/AtNPCw== root@nixos ";

  keys = [ arar-work-mac arar-nixos root-nixos root2-nixos ];
in
{
  # "secret1.age".publicKeys = [ user1 system1 ];
  #"paperless.age".publicKeys = keys;
  #"radarrApiKey.age".publicKeys = keys;
  #"sonarrApiKey.age".publicKeys = keys;
  #"immichDatabase.age".publicKeys = keys;
  #"hashedUserPassword.age".publicKeys = keys;
  #"vaultPassword.age".publicKeys = keys;
  # NOTE: not sure what gitincludes does yet
  #
  #"gitIncludes.age".publicKeys = keys;
  "protonvpnCredentials.age".publicKeys = keys;
  "paperless.age".publicKeys = keys;
  "test.age".publicKeys = keys;
  "vaultwarden.age".publicKeys = keys;
  "smbCredentials.age".publicKeys = keys;
  "cloudflareTunnel.age".publicKeys = keys;
}


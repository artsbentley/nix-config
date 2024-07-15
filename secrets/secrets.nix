let
  arar-work-mac = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIAhxaP+gOSaWKCv2hzVAEbgq6ONvAlEKHpYZ08c4OO2fw4H48Pil/4ESjameYnCtU8XMljdsNg6r28rXERxsxTcPX7o8ktFzqL8Ey440+5cYGlDwSYOkFACOCptq4NVEqckbOjopyI5vd/yty9Ox7GFJ282pwy/zIqvEsKcwY1EH7ZvHctVH0yarUgpMbGYVrZa1ivVG+/Ss4GlSNbR5bU2GjdwvT+3PvvqRZ4oK1fT0D/7HV8Wm4M2K9XIJV4u5fQ/XXR1DiE/2S/46Nc3eJg9ruuWOOEPi7QItRznOfuXXig70wHVdgbfLHHhQwKcylKLiXW426G3IJ0rqDSqmt6idf6wLAR8ilpcCTr2/36AmIALPbHi9rOeednJySpi6H9Mal73dRThs+mPgWFPk1+B2oDy0tx/VDzAebMwbCZ+MV1LvioJVETcZIQWWBpWpl/FLqB4+ffJItUvjoiQgfokcfXjy1UZJLD/zqUwGspmwvOtBGBC9c8Kj6fFoN+o0= arar@arnos-mbp.home ";
  personal-machine = "";
  keys = [ arar-work-mac personal-machine ];
in
{
  # "secret1.age".publicKeys = [ user1 system1 ];
  "paperless.age".publicKeys = keys;
  "radarrApiKey.age".publicKeys = keys;
  "sonarrApiKey.age".publicKeys = keys;
  "immichDatabase.age".publicKeys = keys;
  "hashedUserPassword.age".publicKeys = keys;
  # NOTE: not sure what gitincludes does yet
  "gitIncludes.age".publicKeys = keys;
}

# NOTE: deprecated for now, would look something like this otherwise:
#
# { inputs, lib, config, pkgs, vars, ... }:

# Import the createDirectories function
# let
#   createDirs = import ./create-directories.nix { inherit lib; };
#
#   directories = [
#     "${vars.serviceConfigRoot}/portainer"
#     "${vars.serviceConfigRoot}/jellyfin"
#     "${vars.serviceConfigRoot}/jellyfin/cache"
#     "${vars.serviceConfigRoot}/jellyfin/config"
#     "${vars.serviceConfigRoot}/jellyseerr"
#     "${vars.serviceConfigRoot}/sonarr"
#     "${vars.serviceConfigRoot}/radarr"
#     "${vars.serviceConfigRoot}/prowlarr"
#     "${vars.serviceConfigRoot}/recyclarr"
#     "${vars.serviceConfigRoot}/booksonic"
#     "${vars.nasMount}/Media/Downloads"
#     "${vars.nasMount}/Media/TV"
#     "${vars.nasMount}/Media/Movies"
#     "${vars.nasMount}/Media/Music"
#     "${vars.nasMount}/Media/Audiobooks"
#     "${vars.nasMount}/Media/Books"
#     # "${vars.nasMount}/torrents"
#   ];
# in
# {
#   # Use the function to create directories with appropriate ownership and permissions
#   system.activationScripts.createDirectories = createDirs.createDirectories {
#     directories = directories;
#     user = "share";
#     group = "share";
#     mode = "0775"; # Optional: you can override the mode if needed
#   };
#
#   # Existing services and configurations...
# }

#
#
# { lib }:
#
# # takes in a list of directories and creates them with the proper ownership if
# # they cont exist already
#
# {
#   createDirectories = { directories, user, group, mode ? "0775" }:
#     lib.mkOrder 50 ''
#       for dir in ${lib.concatStringsSep " " directories}; do
#         if [ ! -d "$dir" ]; then
#           mkdir -p "$dir"
#           chown ${user}:${group} "$dir"
#           chmod ${mode} "$dir"
#         fi
#       done
#     '';
# }
#


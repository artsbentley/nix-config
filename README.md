## TODO

- [ ] integrate existing dotfiles into home manager
- [ ] create and mount all accessible NAS mount (for backups)
- [ ] setup restic
- [ ] setup backrest

TODO: seperate nixos into modules, see here:
https://github.com/LongerHV/nixos-configuration/blob/f844fab9280eeefcf689c68b1f630cd42fa3cc8a/modules/nixos/homelab/default.nix
https://www.reddit.com/r/homelab/comments/vhnjna/building_a_home_server_on_nixos/

## scripts

### attach smb

`sudo mount -t cifs -o username=,password=,uid=1000,gid=1000,dir_mode=0777,file_mode=0777 //192.168.2.5//nas mnt/nas`

### running iperf

on server:

- `iperf -s -D` to start deamon
- `htop` to show stats

on client (arar mac):

- `iperf3 -B 192.168.2.3 -c 192.168.2.10 -t 60 `

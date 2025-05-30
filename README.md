## TODO

- [ ] integrate existing dotfiles into home manager
- [ ] setup vaultwarden backup + syncthing to devices

- [ ] restore films form backup drive
- [ ] sync everything from old laptops to SMB
- [ ] setup restic on external drive

- [ ] homepage integration with API's (proxmox, syncthing, etc)
- [ ] homeassistant

Nix does not allow for symlinks outside of the nix store, explore options to
combine Stow + Nix to combine both and make editing of symlink possible without
rebuilding

TODO: seperate nixos into modules, see here:
https://github.com/LongerHV/nixos-configuration/blob/f844fab9280eeefcf689c68b1f630cd42fa3cc8a/modules/nixos/homelab/default.nix
https://www.reddit.com/r/homelab/comments/vhnjna/building_a_home_server_on_nixos/

## scripts

### attaching smb

`sudo mount -t cifs -o username=,password=,uid=1000,gid=1000,dir_mode=0777,file_mode=0777 //192.168.2.5//nas mnt/nas`

### running iperf

on server:

- `iperf -s -D` to start deamon
- `htop` to show stats

on client (arar mac):

- `iperf3 -B 192.168.2.3 -c 192.168.2.10 -t 60 `

## setting up a new machine

```bash
nix-shell -p git
git clone git@github.com:artsbentley/nix-config.git
git clone https://github.com/artsbentley/nix-config.git
```

overwrite the hardware configuration

```bash
mkdir -p machines/nixos/arar/hardware
cp /etc/nixos/hardware-configuration.nix machines/nixos/arar/hardware/default.nix
```

add ssh key for easy ssh

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub arar@local.nixos
```

add age ssh certificate

```bash
scp ~/.ssh/id_rsa arar@local.nixos:~/.ssh/
scp ~/.ssh/id_rsa.pub arar@local.nixos:~/.ssh/
```

restore appdata

```bash
eza nas/Backups/restic/appdata/snapshots -l --sort newest
restic restore latest --target /home/arar/appdata -r nas/Backups/restic/appdata
```

adjust ownership if needed

```bash
sudo chown -R share:share appdata
```

retrieve new tailscale auth token and set agenix secret

## mac installation

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### set-up fish as default shell

```bash
type fish
fish is /etc/profiles/per-user/arar/bin/fish
```

```bash
 echo "/etc/profiles/per-user/arar/bin/fish" | sudo tee -a /etc/shells
```

```bash
chsh -s /etc/profiles/per-user/arar/bin/fish
```

nas structure:

```bash
nas
├── Backups
│   ├── restic
│   │   ├── appdata
│   └── vaultwarden
├── Documents
│   └── Paperless
│       ├── Documents
│       ├── Export
│       └── Import
├── Media
│   ├── Audiobooks
│   ├── Books
│   ├── Downloads
│   ├── Movies
│   ├── Music
│   └── TV
└── Syncthing
    ├── Downloads
    └── obsidian
```

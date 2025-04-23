{
  inputs = {
    # nixpkgs 
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin (for MacOS machines)
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Agenix secret management 
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";

    # Recyclarr
    recyclarr-configs = {
      url = "github:recyclarr/config-templates";
      flake = false;
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix.url = "github:danth/stylix";

    nur.url = "github:nix-community/nur";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, recyclarr-configs, nixvim, nix-index-database, agenix, nur, ... }@inputs:
    let
      inherit (self) outputs;

      users = {
        nabokikh = {
          # avatar = ./files/avatar/face;
          email = "arnoarts@hotmail.com";
          fullName = "Arno Arts";
          gitKey = "C5810093";
          name = "arar";
        };
      };
      hosts = {
        orbstack = {
          name = "orbstack";
          isHomelab = false;
          hasBootloader = false;
          # isVM = true;
        };
        homelab = {
          name = "homelab";
          isHomelab = true;
          hasBootloader = true;
          # isVM = false;
        };
      };

      mkNixosConfiguration = system: hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs username hostname system;
            userConfig = users.${username};
            hostConfig = hosts.${hostname};
            nixosModules = "${self}/modules/nixos";
          };

          modules = [
            agenix.nixosModules.default
            ./hosts/${hostname}

            # Home Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = {
                inherit inputs outputs username hostname system;
                userConfig = users.${username};
                hostConfig = hosts.${hostname};
                nhModules = "${self}/modules/home-manager";
              };
              home-manager.backupFileExtension = "bak";
              home-manager.users.${username} = {
                imports = [
                  agenix.homeManagerModules.default
                  nix-index-database.hmModules.nix-index
                  ./home/${username}/${hostname}
                  # ./users/arar/dotfiles.nix
                  # ./machines/surface-nixos/stylix.nix
                ];
              };
            }
          ];
        };

    in
    {
      darwinConfigurations."arar" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          agenix.darwinModules.default
          ./machines/darwin
          ./machines/darwin/arar
          # ./machines/darwin/arar/system.nix
        ];
      };

      nixosConfigurations = {
        orbstack = mkNixosConfiguration "aarch64-linux" "orbstack" "arar";

        oldorbstack = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
            vars = import ./machines/orbstack/vars.nix;
          };
          modules = [
            agenix.nixosModules.default

            # - MODULES -----------------------------------
            # ./modules/podman

            # - ORB -------------------------------
            ./machines/orb/orb/orbstack.nix
            ./machines/orb/orb/configuration.nix

            # - MACHINE CONFIG -------------------------------
            ./machines/orb/arar
            ./machines/orb
            ./secrets

            # - USER -----------------------------------------
            ./users/arar
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.arar.imports = [
                agenix.homeManagerModules.default
                nix-index-database.hmModules.nix-index
                ./users/arar/dotfiles.nix
              ];
              home-manager.backupFileExtension = "bak";
            }
          ];
        };

        surface = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            vars = import ./machines/surface-nixos/vars.nix;
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            agenix.nixosModules.default

            # surface specific
            # ./machines/surface-nixos/surface-pkgs

            # Base configuration and modules
            ./modules/podman
            # ./modules/tailscale

            # Import the machine config + secrets
            ./machines/surface-nixos
            ./machines/surface-nixos/arar
            ./machines/surface-nixos/arar/hardware
            ./secrets

            # User-specific configurations
            ./users/arar
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.arar.imports = [
                agenix.homeManagerModules.default
                nix-index-database.hmModules.nix-index
                ./users/arar/dotfiles.nix
                ./machines/surface-nixos/stylix.nix
              ];
              home-manager.backupFileExtension = "bak";
            }
          ];
        };

        arar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            vars = import ./machines/nixos/vars.nix;
          };
          modules = [
            # Base configuration and modules
            ./modules/podman
            ./modules/tailscale

            # Import the machine config + secrets
            ./machines/nixos
            ./machines/nixos/arar
            ./machines/nixos/arar/hardware
            ./machines/nixos/arar/backup
            ./machines/nixos/arar/syncthing
            ./secrets
            agenix.nixosModules.default

            # Services and applications
            # TODO: setup GPU acceleration for jellyfin, paperless and immich
            ./containers/arr
            ./containers/paperless
            ./containers/mealie
            ./containers/vaultwarden
            ./containers/cloudflare
            ./containers/homepage
            ./containers/actualbudget
            ./containers/stirling
            ./containers/pangolin
            ./containers/enclosed
            # ./containers/gitea
            # ./containers/watchtower
            # ./containers/backrest

            # User-specific configurations
            ./users/arar
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.arar.imports = [
                agenix.homeManagerModules.default
                nix-index-database.hmModules.nix-index
                ./users/arar/dotfiles.nix
              ];
              home-manager.backupFileExtension = "bak";
            }
          ];
        };
      };
    };
}


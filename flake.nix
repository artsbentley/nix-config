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
        arar = {
          # avatar = ./files/avatar/face;
          email = "arnoarts@hotmail.com";
          fullName = "Arno Arts";
          # gitKey = "C5810093";
          name = "arar";
        };
      };
      hosts = {
        orbstack = {
          name = "orbstack";
          isHomelab = false;
          hasBootloader = false;
          # isVM = true;
          isWorkMachine = false;
        };
        homelab = {
          name = "homelab";
          isHomelab = true;
          hasBootloader = true;
          isWorkMachine = false;
          # isVM = false;
        };
        mac = {
          name = "mac";
          isHomelab = false;
          hasBootloader = false;
          isWorkMachine = false;
          # isVM = false;
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration = system: hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs username hostname system;
            userConfig = users.${username};
            hostConfig = hosts.${hostname};
            nixosModules = "${self}/modules/nixos";
            vars = import ./hosts/${hostname}/vars.nix;
          };

          modules = [
            agenix.nixosModules.default
            ./secrets
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
      #
      # Function for nix-darwin system configuration
      mkDarwinConfiguration = system: hostname: username:
        nix-darwin.lib.darwinSystem {
          system = system;
          specialArgs = {
            inherit inputs outputs username hostname system;
            userConfig = users.${username};
            hostConfig = hosts.${hostname};
            darwinModules = "${self}/modules/darwin"; # Path to your reusable Darwin modules
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            agenix.darwinModules.default
            ./hosts/${hostname}
            inputs.home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = false; # Use packages from nix-darwin system config
              home-manager.useUserPackages = true; # Install HM packages into user profile
              home-manager.extraSpecialArgs = {
                inherit inputs outputs username hostname system;
                userConfig = users.${username};
                hostConfig = hosts.${hostname};
                nhModules = "${self}/modules/home-manager"; # Path to reusable HM modules
              };
              home-manager.backupFileExtension = "bak";
              home-manager.users.${username} = { inputs, pkgs, lib, ... }: {
                home.homeDirectory = lib.mkForce "/Users/${username}";
                imports = [
                  agenix.homeManagerModules.default
                  nix-index-database.hmModules.nix-index
                  ./home/${username}/${hostname}
                ];
              };
            }
          ];
        };
    in
    {
      darwinConfigurations = {
        "kpn" = mkDarwinConfiguration "aarch64-darwin" "mac" "arar";
      };

      nixosConfigurations = {
        orbstack = mkNixosConfiguration "aarch64-linux" "orbstack" "arar";
        homelab = mkNixosConfiguration "x86_64-linux" "homelab" "arar";

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
      };
    };
}


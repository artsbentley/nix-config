{
  inputs = {
    cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs: with inputs;

    flake-utils.lib.eachDefaultSystem (system:
      let
        packageName = "nix-rs";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            cargo2nix.overlays.default
          ];
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.63.0";
          packageFun = import ./Cargo.nix;
          extraRustComponents = [ "clippy" ];
        };

        workspaceShell = rustPkgs.workspaceShell {
          packages = with pkgs; [
            rustfmt
            cargo2nix.packages.${system}.cargo2nix
          ];
        };

        ci = pkgs.rustBuilder.runTests rustPkgs.workspace.cargo2nix { };

      in
      rec {
        packages = {
          ${packageName} = (rustPkgs.workspace.${packageName} { }).bin;
          default = packages.${packageName};
        };
        devShell = workspaceShell;
      }
    );
}


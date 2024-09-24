{
  description = "Configuration de El-Kluster avec NixOS";


  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
    in
    {
      inherit lib;

      nixosConfigurations = {

        master = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/master ];
          specialArgs = { inherit inputs outputs; };
        };

        workers = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/workers ];
          specialArgs = { inherit inputs outputs; };
        };
      };
    };
}

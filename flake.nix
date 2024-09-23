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
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      inherit lib;
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = {

        master = lib.nixosSystem {
          modules = [ ./hosts/master ];
          specialArgs = { inherit inputs outputs; };
        };

        workers = lib.nixosSystem {
          modules = [ ./hosts/workers ];
          specialArgs = { inherit inputs outputs; };
        };
      };
    };
}

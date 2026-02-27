{
  description = "first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixlegion = lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [ ./configuration.nix ];
	};
      };
    };
}

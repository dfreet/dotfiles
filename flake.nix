{
  description = "first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixlegion = lib.nixosSystem {
          inherit system
	  modules = [ 
	    ./configuration.nix
	    nixos-hardware.nixosModules.lenovo-legion-16iax10h
	  ];
	};
      };
      homeConfigurations = {
        devyn = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs
	  modules = [ ./home.nix ];
	};
      };
    };
}

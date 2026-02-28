{
  description = "first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"
  };

  outputs = { self, nixpkgs, nixos-hardware }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixlegion = lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [ 
	    ./configuration.nix
	    nixos-hardware.nixosModules.lenovo-legion-16iax10h
	  ];
	};
      };
    };
}

{
  description = "Rajat's NixOS-WSL configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr = {
      url = "github:herdrdev/herdr"; 
    };	
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs,herdr, nixos-wsl, home-manager, ... }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {
 	 inherit herdr;
        };
        modules = [
          nixos-wsl.nixosModules.default
          ./configuration.nix

          home-manager.nixosModules.home-manager
        ];
      };
    };
}

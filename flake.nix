{
  description = "My Flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };
  
  outputs = { nixpkgs, self, ... }@inputs : {
    nixosConfigurations.yukari = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/nixos
	      inputs.home-manager.nixosModules.home-manager
	      {
	        home-manager.useGlobalPkgs = true;
	        home-manager.users.lord_gabem = import ./modules/home;
          home-manager.extraSpecialArgs = {
            outputs = self;
          };
	      }
      ];
      specialArgs = {
        outputs = self;
      };
    };

    
    
    packages."x86_64-linux" = let
      pkgs = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        overlays = [ inputs.emacs-overlay.overlays.default ];
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "intelephense"
          ];
      };
    in
      {
        emacs = import ./packages/emacs.nix pkgs;
      };
  };
}

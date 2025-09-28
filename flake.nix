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
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      # inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    gabe-backgrounder = {
      url = "github:gabman15/gabe-backgrounder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mpv-remote-node = {
      url = "github:gabman15/mpv-remote-node";
      inputs.nixpkgs.follows = "nixpkgs";
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
            inherit inputs;
            outputs = self;
          };
        }
      ];
      specialArgs = {
        inherit inputs;
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

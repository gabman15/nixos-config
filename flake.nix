{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    mpd-albumart = {
      url = "github:gabman15/mpd-albumart";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mpv-remote-node = {
      url = "github:gabman15/mpv-remote-node";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gensoquote = {
      url = "github:gabman15/gensoquote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jbwar22-mpv-scripts = {
      url = "github:jbwar22/mpv-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, self, ... }@inputs : let
    nixoshosts = [ "yukari" "patchouli" "suwako" ];
    homemgrhosts = [ "gensokyo" ];
    forAllNixOsHosts = nixpkgs.lib.genAttrs nixoshosts;
    forAllHomeMgrHosts = nixpkgs.lib.genAttrs homemgrhosts;
  in {
    nixosConfigurations = forAllNixOsHosts (host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/nixos/hosts/common
        ./modules/nixos/hosts/${host}
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        {
          networking.hostName = host;
          home-manager.useGlobalPkgs = true;
          home-manager.users.lord_gabem = {
            imports = [
              ./modules/home/hosts/common
              ./modules/home/hosts/${host}
            ];
            custom.home.opts.hostname = host;
          };
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
    });

    homeConfigurations = let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      forAllHomeMgrHosts (host: inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          stylix.homeModules.stylix
          ./modules/home/hosts/common
          ./modules/home/hosts/${host}
          {
            home.username = "lord_gabem";
            custom.home.opts.hostname = host;
            home.homeDirectory = "/home/lord_gabem";
          }
        ];

        extraSpecialArgs = {
          inherit inputs;
          outputs = self;
        };
      });

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

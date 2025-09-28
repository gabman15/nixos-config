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
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, stylix, self, ... }@inputs : let
    nixoshosts = [ "yukari" "patchouli" "suwako" "koishi" ];
    homemgrhosts = [ "gensokyo" "nitori" ];
    forAllNixOsHosts = nixpkgs.lib.genAttrs nixoshosts;
    forAllHomeMgrHosts = nixpkgs.lib.genAttrs homemgrhosts;
    nixosUnfreePkgs = [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];
    homeUnfreePkgs = [
      "posy-cursors"
      "discord"
      "steam"
      "steam-unwrapped"
    ];
  in {
    nixosConfigurations = forAllNixOsHosts (host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/nixos/hosts/common
        ./modules/nixos/hosts/${host}
        ./modules/themes
        ./modules/opts
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        {
          stylix.homeManagerIntegration.autoImport = false;
          networking.hostName = host;
          custom.opts.hostname = host;
          home-manager.useGlobalPkgs = true;
          home-manager.users.lord_gabem = {
            imports = [
              ./modules/home/hosts/common
              ./modules/home/hosts/${host}
              ./modules/themes
              ./modules/opts
              inputs.nix-index-database.homeModules.nix-index
              inputs.stylix.homeModules.stylix
            ];
            custom.opts.hostname = host;
            stylix.overlays.enable = false;
          };
          home-manager.extraSpecialArgs = {
            inherit inputs;
            outputs = self;
          };
          nixpkgs.config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) (nixosUnfreePkgs ++ homeUnfreePkgs);
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
          inputs.nix-index-database.homeModules.nix-index
          ./modules/home/hosts/common
          ./modules/home/hosts/${host}
          ./modules/themes
          ./modules/opts
          {
            home.username = "lord_gabem";
            custom.opts.hostname = host;
            home.homeDirectory = "/home/lord_gabem";
            nixpkgs.config.allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) homeUnfreePkgs;
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
        emacs-dev = import ./packages/emacs.nix pkgs "dev";
        emacs = import ./packages/emacs.nix pkgs "minimal";
      };
  };
}

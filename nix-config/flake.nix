{
    description = "My Home Manager configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixgl = {
            url = "github:nix-community/nixGL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ghostty.url = "github:ghostty-org/ghostty";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, nixgl, ghostty, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system; 
                overlays = [
#                    nixgl.overlay
#                    ghostty.overlay
                ];
            };
            ghosttyPackage = pkgs.callPackage ghostty {};
        in {
            homeConfigurations = {
                victor = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ 
                        ./home.nix
                    ];
                    extraSpecialArgs = {
                        ghostty = ghostty.packages.${system}.default;
                        #nixgl = nixgl.packages.${system}.default;
                        inherit nixgl;
                    };
                };
            };
        };
}


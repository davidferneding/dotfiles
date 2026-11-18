{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { username, homeDirectory, system, extraPackages ? (_: [ ]) }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            { home = { inherit username homeDirectory; }; }
            ({ pkgs, ... }: { home.packages = extraPackages pkgs; })
          ];
        };
    in
    {
      homeConfigurations = {
        "david.ferneding" = mkHome {
          username = "david.ferneding";
          homeDirectory = "/Users/david.ferneding";
          system = "aarch64-darwin";
          extraPackages = pkgs: [ pkgs.azure-cli ];
        };
      };
    };
}

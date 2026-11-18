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
      mkHome = { username, homeDirectory, system, modules }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            { home = { inherit username homeDirectory; }; }
          ] ++ map (name: ./modules/${name}.nix) modules;
        };
    in
    {
      homeConfigurations = {
        "david.ferneding" = mkHome {
          username = "david.ferneding";
          homeDirectory = "/Users/david.ferneding";
          system = "aarch64-darwin";
          modules = [ "languages" "cli" "config" "work" ];
        };
      };
    };
}

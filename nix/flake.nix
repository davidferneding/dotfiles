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
      local = import ./local.nix;
    in
    {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${local.system};
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit local; };
      };
    };
}

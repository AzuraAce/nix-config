{
  description = "My Nixos Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # package overlays
    overlays = import ./overlays {inherit inputs;};
    # custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      t14s = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./hosts/t14s/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "oliver@t14s" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;
            monitors = [
              { name = "eDP-1"; res = "2880x1800"; scale = "2"; hz = "90"; pos = "0 0"; }
            ];
        };

        modules = [
          ./home-manager/users/oliver/home.nix
        ];
      };
    };
  };
}

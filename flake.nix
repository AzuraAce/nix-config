{
  description = "My Nixos Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    thealtf4stream-nvim.url = "github:ALT-F4-LLC/thealtf4stream.nvim";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      t14s = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [./hosts/t14s/configuration.nix];
      };
    };

    homeConfigurations = {
      "oliver@t14s" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};

        modules = [./home-manager/users/oliver/home.nix];
      };
    };
  };
}

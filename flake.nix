{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    crulz.url = "github:zserik/crulz-rs";
    crulz.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.burton = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      {
        nixpkgs.overlays = with inputs; [
          crulz.overlay
        ];
      }
      ./burton/configuration.nix
      ];
    };
  };
}

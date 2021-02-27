{
  inputs = {
    crulz.url = "github:zserik/crulz-rs";
  };

  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.burton = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      {
        nixpkgs.overlays = [
          inputs.crulz.overlay
        ];
      }
      ./burton/configuration.nix
      ];
    };
  };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    crulz.url = "github:zseri/crulz-rs";
    crulz.inputs.nixpkgs.follows = "nixpkgs";
    zs-filecrawler.url = "github:zseri/zs-filecrawler";
    zs-filecrawler.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.burton = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      {
        nixpkgs.overlays = with inputs; [
          crulz.overlay
          zs-filecrawler.overlay
        ];
      }
      ./burton/configuration.nix
      ];
    };
  };
}

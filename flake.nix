{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    crulz.url = "github:zseri/crulz-rs";
    crulz.inputs.nixpkgs.follows = "nixpkgs";
    zs-filecrawler.url = "github:zseri/zs-filecrawler";
    zs-filecrawler.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @inputs:
  let
    overlay-stack = {
      nixpkgs.overlays = with inputs; [
        crulz.overlay
        zs-filecrawler.overlay
      ];
    };

  in {
    nixosConfigurations.burton = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        overlay-stack
        ./burton/configuration.nix
        ./burton/hardware-configuration.nix
        ./utils/nix.nix
        ./utils/powerline.nix
        ./i18n/de.nix
      ];
    };
  };
}

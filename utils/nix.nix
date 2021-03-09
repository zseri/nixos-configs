# This file configures Nix:
# - enable Flakes support
# - cache outputs and derivations for offline work
# - enable direnv + nix-direnv
# - enable support for 'nix profile' (ca-references)

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    direnv
    nix-direnv
  ];

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command ca-references flakes
    keep-outputs = true
    keep-derivations = true
  '';
}

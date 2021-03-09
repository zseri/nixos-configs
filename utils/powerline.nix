# Install the Powerline fonts (easier to read when the font size if really small)
{ pkgs, ... }: {
  console.font = "ter-powerline-v16n";
  services.kmscon.extraConfig = ''font-name=Cousine for Powerline Regular'';
  fonts.fonts = [ pkgs.powerline-fonts ];
}

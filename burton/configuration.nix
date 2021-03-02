# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.enable = true;

  networking.hostName = "burton";
  networking.wireless.enable = true;

  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.dhcpcd.enable = true;
  networking.interfaces.enp9s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "nodeadkeys";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  users.users.zseri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" ];
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) (import ./unfree_allow.nix);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = import ./packages.nix pkgs;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
  };

  nix = {
    # enable Flakes (https://nixos.wiki/wiki/Flakes)
    # and cache outputs and derivations for offline work
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

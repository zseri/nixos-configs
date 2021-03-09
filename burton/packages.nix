pkgs:

let
  vscodeExtensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    matklad.rust-analyzer
  ];
in with pkgs; [
  bc
  binutils
  cargo-audit
  cargo-edit
  coreutils
  coq
  crate2nix
  crulz
  curl
  ding
  discord
  dropbear
  evince
  file
  firefox
  gcc
  gimp
  gitFull
  gnome3.gucharmap
  gnome3.meld
  gnused
  gnutar
  gpm
  graphviz
  hexedit
  kak-lsp
  kakoune
  light
  mc
  mixxx
  moreutils
  mosh
  nano
  octaveFull
  odt2txt
  pciutils
  psmisc
  ripgrep
  rustup
  slock
  strace
  texlive.combined.scheme-basic
  thunderbird
  tree
  valgrind
  vlc
  (vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    inherit vscodeExtensions;
  })
  wget
  wireguard
  wireshark
  wpa_supplicant_gui
  xfce.terminal
  xfce.xfce4-cpugraph-plugin
  xfce.xfce4-power-manager
  xfce.xfce4-screenshooter
  xfce.xfce4-whiskermenu-plugin
  zs-filecrawler
]

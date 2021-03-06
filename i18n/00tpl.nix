{ lang, layout, loxtra, variant }:

{
  # Select internationalisation properties.
  i18n.defaultLocale = "${lang}.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
  };
  console.keyMap = "${layout}-${loxtra}-${variant}";

  # Configure keymap in X11
  services.xserver.layout = layout;
  services.xserver.xkbVariant = variant;
}

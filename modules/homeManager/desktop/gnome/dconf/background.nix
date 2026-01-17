{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.gnome.dconf.enable {
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.home.homeDirectory}/Pictures/wallpapers/shaded_landscape.png";
        picture-uri-dark = "file://${config.home.homeDirectory}/Pictures/wallpapers/shaded_landscape.png";
        picture-options = "zoom";
      };
    };
  };
}

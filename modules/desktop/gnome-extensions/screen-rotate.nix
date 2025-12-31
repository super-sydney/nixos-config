{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.screen-rotate.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Screen Rotate extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.screen-rotate.enable {
    home.packages = [ pkgs.gnomeExtensions.screen-rotate ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "screen-rotate@shyzus.github.io" ];
      };
    };
  };
}

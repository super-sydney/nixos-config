{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.rounded-window-corners-reborn.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Rounded Window Corners Reborn extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.rounded-window-corners-reborn.enable {
    home.packages = [ pkgs.gnomeExtensions.rounded-window-corners-reborn ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "rounded-window-corners@fxgn" ];
      };
    };
  };
}

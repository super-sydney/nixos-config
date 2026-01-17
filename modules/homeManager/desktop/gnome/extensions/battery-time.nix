{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.battery-time.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Battery Time (Percentage) Compact extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.battery-time.enable {
    home.packages = [ pkgs.gnomeExtensions.battery-time-percentage-compact ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "batterytimepercentagecompact@sagrland.de" ];
      };
    };
  };
}

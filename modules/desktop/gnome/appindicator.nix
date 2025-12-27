{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.appindicator.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable AppIndicator and KStatusNotifierItem Support extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.appindicator.enable {
    home.packages = [ pkgs.gnomeExtensions.appindicator ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "appindicatorsupport@rgcjonar.gmail.com" ];
      };
    };
  };
}

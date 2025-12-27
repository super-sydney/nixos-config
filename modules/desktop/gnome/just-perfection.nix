{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.just-perfection.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Just Perfection extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.just-perfection.enable {
    home.packages = [ pkgs.gnomeExtensions.just-perfection ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "just-perfection-desktop@just-perfection" ];
      };

      # Extension-specific configuration
      # Uncomment and customize as needed:
      # "org/gnome/shell/extensions/just-perfection" = {
      #   panel = true;
      #   activities-button = false;
      #   app-menu = false;
      # };
    };
  };
}

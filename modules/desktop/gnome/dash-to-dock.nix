{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.dash-to-dock.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Dash to Dock extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.dash-to-dock.enable {
    home.packages = [ pkgs.gnomeExtensions.dash-to-dock ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" ];
      };

      # Extension-specific configuration
      # Uncomment and customize as needed:
      # "org/gnome/shell/extensions/dash-to-dock" = {
      #   dock-position = "BOTTOM";
      #   dock-fixed = false;
      #   intellihide = true;
      #   dash-max-icon-size = 48;
      # };
    };
  };
}

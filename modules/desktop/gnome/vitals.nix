{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.vitals.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Vitals extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.vitals.enable {
    home.packages = [ pkgs.gnomeExtensions.vitals ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "Vitals@CoreCoding.com" ];
      };

      # Extension-specific configuration
      # Uncomment and customize as needed:
      # "org/gnome/shell/extensions/vitals" = {
      #   hot-sensors = [ "_processor_usage_" "_memory_usage_" ];
      #   position-in-panel = 0;
      # };
    };
  };
}

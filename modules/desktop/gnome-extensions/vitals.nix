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

      "org/gnome/shell/extensions/vitals" = {
        alphabetize = true;
        fixed_widths = false;
        hide-icons=false;
        hide-zeros=false;
        hot-sensors=["_temperature_acpi_thermal zone_" "__fan_avg__" "__network-rx_max__" "_storage_free_"];
        icon-style=1;
        menu-centered=true;
        position-in-panel=1;
        show-memory=false;
        show-processor=true;
        show-system=false;
        show-voltage=false;
        use-higher-precision=true;
      };
    };
  };
}

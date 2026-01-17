{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.arcmenu.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable ArcMenu extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.arcmenu.enable {
    # ArcMenu requires the GMenu typelib provided by gnome-menus.
    home.packages = [
      pkgs.gnomeExtensions.arcmenu
      pkgs.gnome-menus
    ];

    # Ensure gjs can locate the GMenu typelib at runtime.
    home.sessionVariables = {
      GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" [ pkgs.gnome-menus ];
    };
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "arcmenu@arcmenu.com" ];
      };

      "org/gnome/shell/extensions/arcmenu" = {
        hide-overview-on-arcmenu-open = true;
        hide-overview-on-startup = true;
        menu-button-appearance = "Icon";
        menu-button-icon = "Distro_Icon";
        distro-icon = 22;
        menu-button-left-click-action = "ArcMenu";
        menu-button-padding = -1; # default
        menu-button-position-offset = 0;
        menu-layout = "Runner";
        multi-monitor = true;
        override-menu-theme = false;
        position-in-panel = "Left";
        show-activities-button = true;
      };
    };
  };
}

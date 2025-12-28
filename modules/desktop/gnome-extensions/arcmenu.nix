{ config, pkgs, lib, ... }:

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

      # "org/gnome/shell/extensions/arcmenu" = {
        
      # };
    };
  };
}

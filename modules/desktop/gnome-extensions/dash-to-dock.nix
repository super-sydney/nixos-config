{
  config,
  pkgs,
  lib,
  ...
}:

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

      "org/gnome/shell/extensions/dash-to-dock" = {
        animation-time = 0.05;
        background-opacity = 0.8;
        custom-theme-shrink = false;
        dash-max-icon-size = 48;
        dock-position = "LEFT";
        height-fraction = 0.9;
        hide-delay = 0.2;
        hide-tooltip = true;
        hot-keys = false;
        intellihide-mode = "ALL_WINDOWS";
        isolate-workspaces = true;
        multi-monitor = true;
        require-pressure-to-show = false;
        show-delay = 0;
        show-mounts = false;
        show-show-apps-button = false;
        show-trash = false;
      };
    };
  };
}

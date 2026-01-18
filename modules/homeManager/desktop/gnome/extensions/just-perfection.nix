{
  config,
  pkgs,
  lib,
  ...
}:

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

      "org/gnome/shell/extensions/just-perfection" = {
        accent-color-icon = false;
        accessibility-menu = false;
        activities-button = true;
        alt-tab-icon-size = 0;
        alt-tab-window-preview-size = 0;
        animation = 1;
        background-menu = true;
        clock-menu = true;
        clock-menu-position = 0;
        clock-menu-position-offset = 0;
        controls-manager-spacing-size = 0;
        dash = true;
        dash-icon-size = 0;
        double-super-to-appgrid = true;
        invert-calendar-column-items = false;
        keyboard-layout = false;
        osd = true;
        panel = true;
        panel-in-overview = true;
        power-icon = true;
        quick-settings = true;
        ripple-box = true;
        search = true;
        show-apps-button = true;
        startup-status = 0;
        support-notifier-type = 0;
        switcher-popup-delay = false;
        theme = false;
        top-panel-position = 0;
        window-demands-attention-focus = false;
        window-maximized-on-create = true;
        window-picker-icon = true;
        window-preview-caption = true;
        window-preview-close-button = true;
        workspace = true;
        workspace-background-corner-size = 0;
        workspace-popup = true;
        workspace-wrap-around = true;
        workspaces-in-app-grid = true;
      };
    };
  };
}

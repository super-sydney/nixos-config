{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.pop-shell.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable pop-shell extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.pop-shell.enable {
    home.packages = [ pkgs.gnomeExtensions.pop-shell ];
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "pop-shell@system76.com" ];
      };
      "org/gnome/shell/extensions/pop-shell" = {
        show-title = true;
        smart-gaps = true;
        fullscreen-launcher = true;
        stacking-with-mouse = false;
        gap-outer = 1;
        gap-inner = 2;
        tile-by-default = true;
        active-hint = false;
        hint-color-rgba = "rgba(203, 166, 247, 1)";

        focus-left = [];
        focus-down = [];
        focus-up = [];
        focus-right = [];
        activate-launcher = [];
        toggle-stacking = [];
        toggle-stacking-global = [];
        management-orientation = [];
        tile-enter = [];
        tile-accept = [];
        tile-reject = [];
        toggle-floating = [];
        toggle-tiling = [];
        tile-move-left = [];
        tile-move-down = [];
        tile-move-up = [];
        tile-move-right = [];
        tile-move-left-global = [];
        tile-move-down-global = [];
        tile-move-up-global = [];
        tile-move-right-global = [];
        tile-orientation = [];
        tile-resize-left = [];
        tile-resize-down = [];
        tile-resize-up = [];
        tile-resize-right = [];
        tile-swap-left = [];
        tile-swap-down = [];
        tile-swap-up = [];
        tile-swap-right = [];
        pop-workspace-down = [];
        pop-workspace-up = [];
        pop-monitor-down = [ ]; # Up/down doesn't work correctly, so use left/right instead
        pop-monitor-up = [ ];
        pop-monitor-left = [ "<Super><Shift>Up" ];
        pop-monitor-right = [ "<Super><Shift>Down" ];
      };
    };
  };
}

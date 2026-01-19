{
  config,
  pkgs,
  lib,
  ...
}:

let
  pop-shell-no-icon = pkgs.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
    postBuild = ''
      ${oldAttrs.postBuild or ""}
      substituteInPlace _build/extension.js \
        --replace-fail "panel.addToStatusArea('pop-shell', indicator.button);" "// panel.addToStatusArea('pop-shell', indicator.button);"
    '';
  });
in
{
  options.gnome.extensions.pop-shell.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable pop-shell extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.pop-shell.enable {
    home.packages = [ pop-shell-no-icon ];
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

        focus-left = [ ];
        focus-down = [ ];
        focus-up = [ ];
        focus-right = [ ];
        activate-launcher = [ ];
        toggle-stacking = [ ];
        toggle-stacking-global = [ ];
        management-orientation = [ ];
        tile-enter = [ ];
        tile-accept = [ ];
        tile-reject = [ ];
        toggle-floating = [ ];
        toggle-tiling = [ ];
        tile-move-left = [ ];
        tile-move-down = [ ];
        tile-move-up = [ ];
        tile-move-right = [ ];
        tile-move-left-global = [ "<Super><Shift>Left" ];
        tile-move-down-global = [ "<Super><Shift>Down" ];
        tile-move-up-global = [ "<Super><Shift>Up" ];
        tile-move-right-global = [ "<Super><Shift>Right" ];
        tile-orientation = [ ];
        tile-resize-left = [ ];
        tile-resize-down = [ ];
        tile-resize-up = [ ];
        tile-resize-right = [ ];
        tile-swap-left = [ ];
        tile-swap-down = [ ];
        tile-swap-up = [ ];
        tile-swap-right = [ ];
        pop-workspace-down = [ ];
        pop-workspace-up = [ ];
        pop-monitor-down = [ ];
        pop-monitor-up = [ ];
        pop-monitor-left = [ ];
        pop-monitor-right = [ ];
      };
    };
  };
}

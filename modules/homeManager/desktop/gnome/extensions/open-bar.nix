{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.open-bar.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Open Bar extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.open-bar.enable {
    home.packages = [ pkgs.gnomeExtensions.open-bar ];
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "openbar@neuromorph" ];
      };
      "org/gnome/shell/extensions/openbar" = {
        # Auto Theming
        autofg-bar = false;
        autofg-menu = false;

        # Top Bar Properties
        bartype = "Trilands";
        position = "Top";
        height = 35.0;
        margin = 0.0;
        set-bottom-margin = true;
        bottom-margin = 0.0;
        set-overview = true;
        set-fullscreen = true;
        fitts-widgets = true;

        # Window-Max Bar
        wmaxbar = false;

        # Bar Foreground
        fgcolor = [
          "0.804"
          "0.839"
          "0.957"
        ];
        dark-fgcolor = [
          "0.804"
          "0.839"
          "0.957"
        ];
        fgalpha = 1.0;

        # Bar Background
        boxalpha = 0.0;
        bgalpha = 0.0;
        isalpha = 1.0;
        iscolor = [
          "0.118"
          "0.118"
          "0.180"
        ];
        dark-iscolor = [
          "0.118"
          "0.118"
          "0.180"
        ];
        shadow = false;

        # Bar Highlights
        autohg-bar = false;
        hcolor = [
          "0.192"
          "0.196"
          "0.267"
        ];
        dark-hcolor = [
          "0.192"
          "0.196"
          "0.267"
        ];
        halpha = 1.0;
        heffect = false;
        hpad = 1.0;
        vpad = 4.0;

        # Bar Border
        bwidth = 0.0;
        bcolor = [
          "0.796"
          "0.651"
          "0.969"
        ];
        dark-bcolor = [
          "0.796"
          "0.651"
          "0.969"
        ];
        neon = false;

        # Popup Menus
        menustyle = false;

        mfgcolor = [
          "0.804"
          "0.839"
          "0.957"
        ];
        dark-mfgcolor = [
          "0.804"
          "0.839"
          "0.957"
        ];
        mfgalpha = 1.0;

        mbgcolor = [
          "0.118"
          "0.118"
          "0.180"
        ];
        dark-mbgcolor = [
          "0.118"
          "0.118"
          "0.180"
        ];
        mbgalpha = 1.0;

        mhcolor = [
          "1"
          "1"
          "1"
        ];
        dark-mhcolor = [
          "1"
          "1"
          "1"
        ];
        mhalpha = 0.2;

        smbgoverride = true;
        smbgcolor = [
          "0.192"
          "0.196"
          "0.267"
        ];
        dark-smbgcolor = [
          "0.192"
          "0.196"
          "0.267"
        ];

        mscolor = [
          "0.796"
          "0.651"
          "0.969"
        ];
        dark-mscolor = [
          "0.796"
          "0.651"
          "0.969"
        ];
        msalpha = 1.0;

        menu-radius = 30.0;
        qtoggle-radius = 30.0;

        # Dash / Dock
        dashdock-style = "Bar";
        dbradius = 30.0;

        # Gnome Shell
        apply-menu-notif = true;
        apply-menu-shell = true;
        apply-accent-shell = true;
        apply-all-shell = true;
      };
    };
  };
}

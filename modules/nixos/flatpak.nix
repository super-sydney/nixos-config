{ pkgs, lib, config, ... }:

{
  options.flatpak.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Flatpak with default packages.";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
          "app.zen_browser.zen"
          "com.github.tchx84.Flatseal"
      ];
    };

    xdg.portal = {
      enable = true;
      # GNOME primary portal with GTK fallback
      extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
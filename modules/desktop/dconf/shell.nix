{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = ["zen-beta.desktop" "org.gnome.Nautilus.desktop" "obsidian.desktop" "org.jellyfin.JellyfinDesktop.desktop"];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
  };
}

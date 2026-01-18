{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.gnome.dconf.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        favorite-apps = [
          "zen-beta.desktop"
          "org.gnome.Nautilus.desktop"
          "obsidian.desktop"
          "org.jellyfin.JellyfinDesktop.desktop"
        ];
      };

      "org/gnome/shell/mutter" = {
        attach-modal-dialogs = false;
        workspaces-only-on-primary = false;
      };

      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Shift><Super>s" ];
        toggle-application-view = [ "<Super>d" ];
        toggle-overview = [ "<Super>a" ];
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
    };
  };
}

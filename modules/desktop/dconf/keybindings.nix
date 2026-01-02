{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      minimize = [ "<Super>h" ];
      maximize = [ "<Super>m" ];
      # move-to-monitor-down = [ "<Super><Shift>Down" ];
      # move-to-monitor-left = [ "<Super><Shift>Left" ];
      # move-to-monitor-right = [ "<Super><Shift>Right" ];
      # move-to-monitor-up = [ "<Super><Shift>Up" ];

      # Use pop-shell keybinds for monitor movement
      move-to-monitor-down = [ ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-monitor-up = [ ];

      move-to-workspace-down = [ "<Super><Control><Shift>Down" ];
      move-to-workspace-left = [ "<Super><Control><Shift>Left" ];
      move-to-workspace-right = [ "<Super><Control><Shift>Right" ];
      move-to-workspace-up = [ "<Super><Control><Shift>Up" ];

      switch-to-workspace-down = [ "<Super><Control>Down" ];
      switch-to-workspace-left = [ "<Super><Control>Left" ];
      switch-to-workspace-right = [ "<Super><Control>Right" ];
      switch-to-workspace-up = [ "<Super><Control>Up" ];

      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
    };
  };
}

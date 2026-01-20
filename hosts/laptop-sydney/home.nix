{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/homeManager
    inputs.zen-browser.homeModules.beta
  ];

  # Communication
  # discord.enable = true;
  mattermost.enable = true;
  signalDesktop.enable = true;
  vesktop.enable = true;

  # Games
  adwsteamgtk.enable = true;
  cartridges.enable = true;
  heroic.enable = true;
  # lutris.enable = true;
  osuLazer.enable = true;
  prismlauncher.enable = true;

  # Media
  jellyfinMediaPlayer.enable = true;
  monophony.enable = true;
  qbittorrent.enable = true;
  vlc.enable = true;

  # Utilities
  calibre.enable = true;
  gimp.enable = true;
  gitkraken.enable = true;
  gnomeExtensionManager.enable = true;
  gnomeTweaks.enable = true;
  hieroglyphic.enable = true;
  # inputRemapper.enable = true;
  # obs-studio.enable = true;
  obsidian.enable = true;
  pikaBackup.enable = true;
  piper.enable = true;
  protonAuthenticator.enable = true;
  protonvpnGui.enable = true;
  qdirstat.enable = true;
  qmk.enable = true;
  solaar.enable = true;
  todoist.enable = true;
  zenBrowser.enable = true;

  # Desktop
  gtkTheme.enable = true;

  gnome = {
    enable = true;

    extensions = {
      appindicator.enable = true;
      arcmenu.enable = true;
      blur-my-shell.enable = true;
      battery-time.enable = true;
      dash-to-dock.enable = true;
      just-perfection.enable = true;
      open-bar.enable = true;
      pop-shell.enable = true;
      quick-settings-audio-panel.enable = true;
      quicksettings-audio-devices-renamer.enable = true;
      rounded-window-corners-reborn.enable = true;
      screen-rotate.enable = true;
      user-themes.enable = true;
      vitals.enable = true;
    };
  };

  # Editors
  vscode.enable = true;

  # Languages
  c.enable = true;
  python.enable = true;

  # Terminal
  fish.enable = true;
  kitty.enable = true;

  # Terminal tools
  git.enable = true;
  wine.enable = true;

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web browser - Zen Browser
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";

      # Video - VLC
      "video/mp4" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/x-msvideo" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";

      # Audio - VLC
      "audio/mpeg" = "vlc.desktop";
      "audio/x-wav" = "vlc.desktop";
      "audio/flac" = "vlc.desktop";
      "audio/x-vorbis+ogg" = "vlc.desktop";
      "audio/mp4" = "vlc.desktop";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}

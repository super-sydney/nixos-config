{
  config,
  pkgs,
  inputs,
  ...
}:

let
  moduleSets = import ../../modules;
in
{
  imports = builtins.attrValues moduleSets.homeManagerModules ++ [
    inputs.zen-browser.homeModules.beta
  ];

  # Games
  osuLazer.enable = true;
  prismlauncher.enable = true;

  # Communication
  # discord.enable = true;
  mattermost.enable = true;
  signalDesktop.enable = true;
  vesktop.enable = true;

  # Media
  jellyfinMediaPlayer.enable = true;
  qbittorrent.enable = true;
  vlc.enable = true;

  # Utilities
  calibre.enable = true;
  gimp.enable = true;
  gitkraken.enable = true;
  gnomeExtensionManager.enable = true;
  gnomeTweaks.enable = true;
  inputRemapper.enable = true;
  obsidian.enable = true;
  opentabletdriver.enable = true;
  pikaBackup.enable = true;
  protonvpnGui.enable = true;
  qdirstat.enable = true;
  qmk.enable = true;
  solaar.enable = true;
  wine.enable = true;

  # Desktop
  gnome.enable = true;
  gtkTheme.enable = true;

  # Editors
  vscode.enable = true;

  # Languages
  c.enable = true;
  python.enable = true;

  # Terminal
  fish.enable = true;
  kitty.enable = true;
  git.enable = true;

  # Gnome extensions
  gnome.extensions.appindicator.enable = true;
  gnome.extensions.arcmenu.enable = true;
  gnome.extensions.dash-to-dock.enable = true;
  gnome.extensions.blur-my-shell.enable = true;
  gnome.extensions.open-bar.enable = true;
  gnome.extensions.just-perfection.enable = true;
  gnome.extensions.vitals.enable = true;
  gnome.extensions.user-themes.enable = true;
  gnome.extensions.screen-rotate.enable = true;

  # Utilities
  zenBrowser.enable = true;

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

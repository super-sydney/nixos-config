{ config, pkgs, ... }:

let
  moduleSets = import ../../modules;
in
{
  imports = builtins.attrValues moduleSets.homeManagerModules;

  # Games
  osuLazer.enable = true;
  prismlauncher.enable = true;

  # Communication
  discord.enable = true;
  mattermost.enable = true;
  signalDesktop.enable = true;

  # Media
  jellyfinMediaPlayer.enable = true;
  qbittorrent.enable = true;
  vlc.enable = true;

  # Utilities
  calibre.enable = true;
  gimp.enable = true;
  gitkraken.enable = true;
  inputRemapper.enable = true;
  obsidian.enable = true;
  opentabletdriver.enable = true;
  pikaBackup.enable = true;
  piper.enable = true;
  protonvpnGui.enable = true;
  qdirstat.enable = true;
  wine.enable = true;

  # Desktop
  gnome.enable = true;
  gtk.enable = true;

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
  gnome.extensions.dash-to-dock.enable = true;
  gnome.extensions.blur-my-shell.enable = true;
  gnome.extensions.just-perfection.enable = true;
  gnome.extensions.vitals.enable = true;
  gnome.extensions.user-themes.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}

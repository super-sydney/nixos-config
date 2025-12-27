{ config, lib, ... }:

{
  imports = [
    ./appindicator.nix
    ./blur-my-shell.nix
    ./dash-to-dock.nix
    ./just-perfection.nix
    ./user-themes.nix
    ./vitals.nix
  ];

  options.gnome.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GNOME shell configuration.";
  };

  config = lib.mkIf config.gnome.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
      };

      # Set GNOME accent color to Catppuccin Mocha Mauve
      "org/gnome/desktop/interface" = {
        accent-color = "purple";
      };
    };
  };
}

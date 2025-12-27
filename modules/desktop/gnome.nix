{ config, pkgs, lib, ...}:

{
  options.gnome.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GNOME theming and extensions.";
  };

  config = lib.mkIf config.gnome.enable {
    gtk = {
      enable = true;

      iconTheme = {
        name = "Tela-purple";
        package = pkgs.tela-icon-theme;
      };

      # Catppuccin GTK/Shell theme (ensure the name matches the package variant)
      theme = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
        package = pkgs.catppuccin-gtk;
      };

      cursorTheme = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme = true
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme = true
        '';
      };
    };
    
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      };

      # Set GNOME accent color to Catppuccin Mocha Mauve
      "org/gnome/desktop/interface" = {
        accent-color = "purple";
      };
    };

    home.packages = with pkgs; [
        gnomeExtensions.user-themes
    ];
  };
}

{ config, pkgs, lib, ...}:

let
  breezexDark = pkgs.stdenv.mkDerivation {
    pname = "breezex-dark-cursor";
    version = "2.0.1";

    src = pkgs.fetchurl {
      url = "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.1/BreezeX-Dark.tar.xz";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/share/icons
      cp -r BreezeX-Dark $out/share/icons/
    '';
  };

  telaPurple = pkgs.stdenv.mkDerivation {
    pname = "tela-icon-theme-purple";
    version = "2025-02-10";

    src = pkgs.fetchurl {
      url = "https://github.com/vinceliuice/Tela-icon-theme/archive/refs/tags/2025-02-10.tar.gz";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };

    nativeBuildInputs = with pkgs; [ bash ];

    installPhase = ''
      chmod +x install.sh
      ./install.sh -c purple -d $out/share/icons -n Tela-purple
    '';
  };

  catppuccinMochaMauve = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-mocha-mauve";
    version = "1.0.3";

    src = pkgs.fetchurl {
      url = "https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-mauve-standard+default.zip";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };

    nativeBuildInputs = with pkgs; [ unzip ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/share/themes
      cp -r catppuccin-mocha-mauve-standard+default $out/share/themes/Catppuccin-Mocha-Standard-Mauve-Dark

      # Also make config directories available for symlinking
      mkdir -p $out/config
      cp -r catppuccin-mocha-mauve-standard+default/gtk-3.0 $out/config/
      cp -r catppuccin-mocha-mauve-standard+default/gtk-4.0 $out/config/
    '';
  };

in {
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
        package = telaPurple;
      };

      # Catppuccin GTK/Shell theme (ensure the name matches the package variant)
      theme = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
        package = catppuccinMochaMauve;
      };

      cursorTheme = {
        name = "BreezeX-Dark";
        package = breezexDark;
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

    # Copy GTK config directories to ~/.config
    xdg.configFile."gtk-3.0".source = "${catppuccinMochaMauve}/config/gtk-3.0";
    xdg.configFile."gtk-4.0".source = "${catppuccinMochaMauve}/config/gtk-4.0";

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
        breezexDark
        telaPurple
        catppuccinMochaMauve
    ];
  };
}

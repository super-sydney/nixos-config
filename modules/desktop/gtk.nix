{
  config,
  pkgs,
  lib,
  ...
}:

let
  breezexDark = pkgs.stdenv.mkDerivation {
    pname = "breezex-dark-cursor";
    version = "2.0.1";

    src = pkgs.fetchurl {
      url = "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.1/BreezeX-Dark.tar.xz";
      sha256 = "jN90NGaw8VZf5fKQ3UjvTALZF3hFjQ08xWQ3UVJVtlM=";
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
      sha256 = "sfPnbjB71IsX8L9V0vWnzp9EWxJ/Qn4R95pjKnnjz08=";
    };

    nativeBuildInputs = with pkgs; [
      bash
      gtk3
    ];

    patchPhase = ''
      patchShebangs install.sh
    '';

    installPhase = ''
      ./install.sh -c purple -d $out/share/icons -n Tela
    '';

    # Skip fixupPhase entirely - no need to scan 19k+ icon files
    # for shebangs, references, or binary patching
    dontFixup = true;
  };

  catppuccinMochaMauve = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-mocha-mauve";
    version = "1.0.3";

    src = pkgs.fetchurl {
      url = "https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-mauve-standard+default.zip";
      sha256 = "y6zaxhYfmMMV+4Z0DiFCbvbdpk8K1pFXzyjzod2kRv4=";
    };

    nativeBuildInputs = with pkgs; [ unzip ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/share/themes
      cp -r catppuccin-mocha-mauve-standard+default* $out/share/themes/

      # Also make config directories available for symlinking
      mkdir -p $out/config
      cp -r catppuccin-mocha-mauve-standard+default/gtk-3.0 $out/config/
      cp -r catppuccin-mocha-mauve-standard+default/gtk-4.0 $out/config/
    '';
  };

in
{
  options.gtkTheme.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GTK theming configuration.";
  };

  config = lib.mkIf config.gtkTheme.enable {
    gtk = {
      enable = true;

      iconTheme = {
        name = "Tela-purple-dark";
        package = telaPurple;
      };

      # Catppuccin GTK/Shell theme (ensure the name matches the package variant)
      theme = {
        name = "catppuccin-mocha-mauve-standard+default";
        package = catppuccinMochaMauve;
      };

      cursorTheme = {
        name = "BreezeX-Dark";
        package = breezexDark;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    home.packages = with pkgs; [
      breezexDark
      telaPurple
      catppuccinMochaMauve
    ];
  };
}

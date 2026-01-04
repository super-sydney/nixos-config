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

  catppuccinKorpsvart = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-gtk-theme-korpsvart";
    version = "f25d8cf";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Catppuccin-GTK-Theme";
      rev = "f25d8cf688d8f224f0ce396689ffcf5767eb647e";
      hash = "sha256-W+NGyPnOEKoicJPwnftq26iP7jya1ZKq38lMjx/k9ss=";
    };

    nativeBuildInputs = with pkgs; [
      bash
      sassc
      gtk-engine-murrine
      gnome-themes-extra
    ];

    dontFixup = true;

    installPhase = ''
      runHook preInstall

      cd themes
      patchShebangs install.sh gtkrc.sh

      mkdir -p $out/share/themes
      ./install.sh -d $out/share/themes -n Catppuccin -t mauve -c dark -s standard

      mkdir -p $out/config
      cp -r $out/share/themes/Catppuccin-Mauve-Dark/gtk-3.0 $out/config/
      cp -r $out/share/themes/Catppuccin-Mauve-Dark/gtk-4.0 $out/config/

      runHook postInstall
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
        name = "Catppuccin-Mauve-Dark";
        package = catppuccinKorpsvart;
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
      catppuccinKorpsvart
      gtk-engine-murrine
      gnome-themes-extra
      sassc
    ];
  };
}

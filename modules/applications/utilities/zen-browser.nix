{
  pkgs,
  lib,
  config,
  ...
}:

let
  # userChromeSrc = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/omeyenburg/catppuccin-zen-browser/main/themes/Mocha/Mauve/userChrome.css";
  #   sha256 = "1lvpxcfzg969jxn1djl8adrfnw76djhgb8pi69zvld61qxjrlgcc";
  # };
  # userContentSrc = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/omeyenburg/catppuccin-zen-browser/main/themes/Mocha/Mauve/userContent.css";
  #   sha256 = "0jnlgkmk2mswzrwfhis9skk6a9svc995bd1a9292hy94wr2kqyi9";
  # };
in
{
  options.zenBrowser.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Zen Browser via zen-browser flake and apply Catppuccin Mocha Mauve theme CSS.";
  };

  config = lib.mkIf config.zenBrowser.enable {
    # Install Zen Browser as a package
    programs.zen-browser.enable = true;

    # Manage profiles.ini with force = true so rebuild doesn't fail when it already exists
    # This file will be created/updated by Home Manager, allowing the browser to use it
    home.file.".zen/profiles.ini" = {
      force = true;
      text = "";
    };
  };
}

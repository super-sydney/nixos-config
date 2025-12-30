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

    # Create profiles.ini only if it doesn't already exist
    # This ensures existing profiles are preserved across rebuilds
    home.activation.zenBrowserProfilesInit = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -f "$HOME/.zen/profiles.ini" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/.zen"
        $DRY_RUN_CMD echo "Please replace this to use the profile you want" > "$HOME/.zen/profiles.ini"
      fi
    '';
  };
}

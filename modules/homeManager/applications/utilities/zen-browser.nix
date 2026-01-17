{
  config,
  pkgs,
  lib,
  ...
}:

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
    home.activation.zenBrowserProfilesInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f "$HOME/.zen/profiles.ini" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/.zen"
        $DRY_RUN_CMD echo "Please replace this to use the profile you want" > "$HOME/.zen/profiles.ini"
      fi
    '';
  };
}

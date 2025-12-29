{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.gnomeExtensionManager.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GNOME Extension Manager.";
  };

  config = lib.mkIf config.gnomeExtensionManager.enable {
    home.packages = with pkgs; [ gnome-extension-manager ];
  };
}
